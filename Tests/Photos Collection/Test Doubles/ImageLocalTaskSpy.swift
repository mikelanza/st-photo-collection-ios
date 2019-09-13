//
//  ImageLocalServiceSpy.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 12/09/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import UIKit
import STPhotoCore

class ImageLocalTaskSpy: ImageLocalTask {
    var image: UIImage?
    var fetchImageCalled: Bool = false
    var shouldFailFetchImage: Bool = false
    
    override func fetchImage(url: String?, completionHandler: @escaping (Result<UIImage?, OperationError>) -> Void) {
        self.fetchImageCalled = true
        
        if self.shouldFailFetchImage {
            completionHandler(Result.failure(OperationError.noDataAvailable))
        } else {
            completionHandler(Result.success(self.image))
        }
    }
}
