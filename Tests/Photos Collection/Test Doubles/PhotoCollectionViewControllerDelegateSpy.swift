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
    var photoCollectionViewControllerNavigateToPhotoDetailsForPhotoIdCalled: Bool = false
 
    func photoCollectionViewController(_ viewController: PhotoCollectionViewController?, navigateToPhotoDetailsFor photoId: String?) {
        self.photoCollectionViewControllerNavigateToPhotoDetailsForPhotoIdCalled = true
    }
}
