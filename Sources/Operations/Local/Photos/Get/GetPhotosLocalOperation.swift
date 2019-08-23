//
//  GetCommentsLocalOperation.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 02/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import Foundation
import STPhotoCore

class GetPhotosLocalOperation: AsynchronousOperation {
    private let model: GetPhotosOperationModel.Request
    private var operationCompletionHandler: ((Result<GetPhotosOperationModel.Response, OperationError>) -> Void)
    
    var shouldFail: Bool = false
    var delay: Int = Int.random(in: 1...3)
    
    init(model: GetPhotosOperationModel.Request, completionHandler: @escaping ((Result<GetPhotosOperationModel.Response, OperationError>) -> Void)) {
        self.model = model
        self.operationCompletionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(self.delay)) {
            if self.shouldFail {
                self.noDataAvailableErrorBlock()
            } else {
                self.successBlock(response: GetPhotosOperationModel.Response(photos: self.photos()))
            }
        }
    }
    
    private func photos() -> [STPhoto] {
        let count: Int = Int.random(in: 20...40)
        var photos: [STPhoto] = []
        for i in 0..<count {
            let photo = STPhoto(id: String(i))
            photo.likeCount = i
            photo.user = self.user(i: i)
            photos.append(photo)
        }
        return photos
    }
    
    private func user(i: Int) -> STUser {
        let user = STUser(id: "userId\(i)")
        user._firstName = Bool.random() ? "John Little Johnny \(i)" : "John \(i)"
        user._lastName = "Doe \(i)"
        return user
    }
    
    // MARK: - Success
    
    private func successBlock(response: GetPhotosOperationModel.Response) {
        self.operationCompletionHandler(Result.success(response))
        self.completeOperation()
    }
    
    // MARK: - Operation error
    
    private func noDataAvailableErrorBlock() {
        self.operationCompletionHandler(Result.failure(OperationError.noDataAvailable))
        self.completeOperation()
    }
}
