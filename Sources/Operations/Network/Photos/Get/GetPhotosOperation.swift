//
//  GetPhotosOperation.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 02/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import Foundation
import STPhotoCore

class GetPhotosOperation: AsynchronousOperation {
    private let model: GetPhotosOperationModel.Request
    private var operationCompletionHandler: (Result<GetPhotosOperationModel.Response, OperationError>) -> Void
    
    private var task: URLSessionDataTask?
    
    init(model: GetPhotosOperationModel.Request, completionHandler: @escaping (Result<GetPhotosOperationModel.Response, OperationError>) -> Void) {
        self.model = model
        self.operationCompletionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        guard let request = GetPhotosOperationRequestBuilder(model: self.model).request() else {
            self.noDataAvailableErrorBlock()
            return
        }
        
        self.task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.verifyData(data: data)
        }
        self.task?.resume()
    }
    
    private func verifyData(data: Data?) {
        if let data = data {
            self.decodeData(data: data)
        } else {
            self.noDataAvailableErrorBlock()
        }
    }
    
    private func decodeData(data: Data) {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
            let photos = try decoder.decode([STPhoto].self, from: data)
            let response = GetPhotosOperationModel.Response(photos: photos)
            self.successBlock(response: response)
        } catch {
            self.cannotParseResponseErrorBlock()
        }
    }
    
    override func cancel() {
        self.task?.cancel()
        super.cancel()
    }
    
    // MARK: - Success
    
    private func successBlock(response: GetPhotosOperationModel.Response) {
        self.operationCompletionHandler(Result.success(response))
        self.completeOperation()
    }
    
    // MARK: - Operation errors
    
    private func noDataAvailableErrorBlock() {
        self.operationCompletionHandler(Result.failure(OperationError.noDataAvailable))
        self.completeOperation()
    }
    
    private func cannotParseResponseErrorBlock() {
        self.operationCompletionHandler(Result.failure(OperationError.cannotParseResponse))
        self.completeOperation()
    }
}
