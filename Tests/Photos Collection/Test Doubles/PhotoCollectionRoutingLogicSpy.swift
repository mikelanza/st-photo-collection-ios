//
//  PhotoCollectionRoutingLogicSpy.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore

class PhotoCollectionRoutingLogicSpy: NSObject, PhotoCollectionRoutingLogic, PhotoCollectionDataPassing {
    var dataStore: PhotoCollectionDataStore?
    
    var removeViewControllerCalled: Bool = false
    
    var presentPhotoDetailViewCalled: Bool = false
    
    func removeViewController() {
        self.removeViewControllerCalled = true
    }

    func presentPhotoDetailView(photo: STPhoto) {
        self.presentPhotoDetailViewCalled = true
    }
}

