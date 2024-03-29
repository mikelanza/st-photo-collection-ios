//
//  STPhotoCollectionBusinessLogicSpy.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import UIKit

class STPhotoCollectionBusinessLogicSpy: STPhotoCollectionBusinessLogic {
    var shouldFetchEntityDetailsCalled: Bool = false
    var shouldFetchEntityPhotosCalled: Bool = false
    var shouldFetchNextEntityPhotosCalled: Bool = false
    var shouldPresentPhotoCalled: Bool = false
    var shouldFetchImageForPhotoCalled: Bool = false
    var setModelCalled: Bool = false
    var setPhotoItemSizeCalled: Bool = false
    
    func shouldFetchEntityDetails() {
        self.shouldFetchEntityDetailsCalled = true
    }
    
    func shouldFetchEntityPhotos() {
        self.shouldFetchEntityPhotosCalled = true
    }
    
    func shouldFetchNextEntityPhotos() {
        self.shouldFetchNextEntityPhotosCalled = true
    }
    
    func shouldPresentPhoto(request: STPhotoCollection.PresentPhoto.Request) {
        self.shouldPresentPhotoCalled = true
    }
    
    func shouldFetchImageForPhoto(request: STPhotoCollection.FetchImage.Request) {
        self.shouldFetchImageForPhotoCalled = true
    }
    
    func setModel(model: STPhotoCollection.Model) {
        self.setModelCalled = true
    }
    
    func setPhotoItemSize(size: CGSize) {
        self.setPhotoItemSizeCalled = true
    }
}

