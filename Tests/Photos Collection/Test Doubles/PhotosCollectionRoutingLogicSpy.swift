//
//  PhotosCollectionRoutingLogicSpy.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore

class PhotosCollectionRoutingLogicSpy: NSObject, PhotosCollectionRoutingLogic, PhotosCollectionDataPassing {
    var dataStore: PhotosCollectionDataStore?
    
    var removeViewControllerCalled: Bool = false
    
    var presentPhotoDetailViewCalled: Bool = false
    
    func removeViewController() {
        self.removeViewControllerCalled = true
    }

    func presentPhotoDetailView(photo: STPhoto) {
        self.presentPhotoDetailViewCalled = true
    }
}

