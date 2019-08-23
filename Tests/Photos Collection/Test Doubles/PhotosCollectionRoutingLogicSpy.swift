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
    
    var popViewControllerCalled: Bool = false
    
    var presentLoginViewCalled: Bool = false
    var presentPhotoDetailViewCalled: Bool = false
    
    
    func popViewController() {
        self.popViewControllerCalled = true
    }
    
    func presentLoginView() {
        self.presentLoginViewCalled = true
    }

    func presentPhotoDetailView(photo: STPhoto) {
        self.presentPhotoDetailViewCalled = true
    }
}

