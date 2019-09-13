//
//  STPhotoCollectionWorkerDelegateSpy.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 13/09/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//
@testable import STPhotoCollection
import UIKit
import STPhotoCore

class STPhotoCollectionWorkerDelegateSpy: STPhotoCollectionWorkerDelegate {
    var successDidGetGeoEntityCalled: Bool = false
    var failureDidGetGeoEntityCalled: Bool = false
    var successDidFetchPhotoImageCalled: Bool = false
    var failureDidFetchPhotoImageCalled: Bool = false
    var successDidFetchPhotosCalled: Bool = false
    var failureDidFetchPhotosCalled: Bool = false
    
    func successDidGetGeoEntity(geoEntity: GeoEntity?) {
        self.successDidGetGeoEntityCalled = true
    }
    
    func failureDidGetGeoEntity(error: OperationError) {
        self.failureDidGetGeoEntityCalled = true
    }
    
    func successDidFetchPhotoImage(displayedPhoto: STPhotoCollection.DisplayedPhoto, image: UIImage?) {
        self.successDidFetchPhotoImageCalled = true
    }
    
    func failureDidFetchPhotoImage(displayedPhoto: STPhotoCollection.DisplayedPhoto, error: OperationError) {
        self.failureDidFetchPhotoImageCalled = true
    }
    
    func successDidFetchPhotos(photos: [STPhoto]) {
        self.successDidFetchPhotosCalled = true
    }
    
    func failureDidFetchPhotos(error: OperationError) {
        self.failureDidFetchPhotosCalled = true
    }
}
