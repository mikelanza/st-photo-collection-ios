//
//  PhotoCommentsLocalService.swift
//  STPhotoDetails
//
//  Created by Dimitri Strauneanu on 04/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import Foundation
import STPhotoCore

class PhotoPhotosLocalService: PhotosServiceProtocol {
    let operationQueue = OperationQueue()
        
    func fetchPhotos(photoIds: [String]?, entityFilter: GetPhotosOperationModel.EntityFilter?, completionHandler: @escaping (Result<[STPhoto], OperationError>) -> Void) {
        let operation = GetPhotosLocalOperation(model: GetPhotosOperationModel.Request(photoIds: photoIds, entityFilter: entityFilter)) { (result) in
            switch result {
            case .success(let value): completionHandler(Result.success(value.photos)); break
            case .failure(let error): completionHandler(Result.failure(error)); break
            }
        }
        
        self.operationQueue.addOperation(operation)
    }
}
