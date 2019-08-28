//
//  PhotoCollectionViewControllerDelegateSpy.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 28/08/2019.
//  Copyright © 2019 mikelanza. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore

class PhotoCollectionViewControllerDelegateSpy: NSObject, PhotoCollectionViewControllerDelegate {
    var photosCollectionViewControllerNavigateToPhotoDetailsForPhotoIdCalled: Bool = false
 
    func photoCollectionViewController(_ viewController: PhotosCollectionViewController?, navigateToPhotoDetailsFor photoId: String?) {
        self.photosCollectionViewControllerNavigateToPhotoDetailsForPhotoIdCalled = true
    }
}
