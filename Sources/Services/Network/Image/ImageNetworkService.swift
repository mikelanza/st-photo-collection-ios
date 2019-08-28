//
//  ImageNetworkService.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 04/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import UIKit
import STPhotoCore

class ImageNetworkService: ImageServiceProtocol {
    let operationQueue = OperationQueue()
        
    func fetchImage(url: String?, completionHandler: @escaping (Result<UIImage?, OperationError>) -> Void) {
        let operation = GetImageOperation(model: GetImageOperationModel.Request(imageUrl: url)) { result in
            switch result {
                case .success(let value): completionHandler(Result.success(value.image)); break
                case .failure(let error): completionHandler(Result.failure(error)); break
            }
        }
        self.operationQueue.addOperation(operation)
    }
}