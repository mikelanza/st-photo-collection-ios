//
//  STPhotoCollectionViewControllerDelegateSpy.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 28/08/2019.
//  Copyright © 2019 mikelanza. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore

class STPhotoCollectionViewControllerDelegateSpy: NSObject, STPhotoCollectionViewControllerDelegate {
    var photoCollectionViewControllerNavigateToPhotoDetailsForPhotoIdCalled: Bool = false
 
    func photoCollectionViewController(_ viewController: STPhotoCollectionViewController?, navigateToPhotoDetailsFor photoId: String?) {
        self.photoCollectionViewControllerNavigateToPhotoDetailsForPhotoIdCalled = true
    }
}
