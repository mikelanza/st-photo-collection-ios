//
//  PhotosLocalTaskSpy.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 13/09/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore

class PhotosLocalTaskSpy: PhotosLocalTask {
    var fetchPhotosCalled: Bool = false
    var shouldFailFetchPhotos: Bool = false
    
    override func fetchPhotos(model: PhotosTaskModel.Fetch, completionHandler: @escaping (Result<[STPhoto], OperationError>) -> Void) {
        self.fetchPhotosCalled = true
        if self.shouldFailFetchPhotos {
            completionHandler(Result.failure(OperationError.noDataAvailable))
        } else {
            completionHandler(Result.success([]))
        }
    }
}
