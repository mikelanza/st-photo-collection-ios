//
//  STPhotoCollectionPresentationLogicSpy.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection

class STPhotoCollectionPresentationLogicSpy: STPhotoCollectionPresentationLogic {
    var presentFetchedPhotosCalled: Bool = false
    var presentEntityDetailsCalled: Bool = false
    var presentWillFetchEntityDetailsCalled: Bool = false
    var presentDidFetchEntityDetailsCalled: Bool = false
    var presentWillFetchPhotosCalled: Bool = false
    var presentDidFetchPhotosCalled: Bool = false
    var presentNoPhotosCalled: Bool = false
    var presentNoMorePhotosCalled: Bool = false
    var presentPhotoDetailViewCalled: Bool = false
    var presentLoginViewCalled: Bool = false
    var presentDeletePhotoCalled: Bool = false
    var presentWillFetchImageCalled: Bool = false
    var presentDidFetchImageCalled: Bool = false
    var presentImageCalled: Bool = false
    
    func presentFetchedPhotos(response: STPhotoCollection.FetchPhotos.Response) {
        self.presentFetchedPhotosCalled = true
    }
    
    func presentEntityDetails(response: STPhotoCollection.PresentEntityDetails.Response) {
        self.presentEntityDetailsCalled = true
    }
    
    func presentWillFetchEntityDetails() {
        self.presentWillFetchEntityDetailsCalled = true
    }
    
    func presentDidFetchEntityDetails() {
        self.presentDidFetchEntityDetailsCalled = true
    }
    
    func presentWillFetchPhotos() {
        self.presentWillFetchPhotosCalled = true
    }
    
    func presentDidFetchPhotos() {
        self.presentDidFetchPhotosCalled = true
    }
    
    func presentNoPhotos() {
        self.presentNoPhotosCalled = true
    }
    
    func presentNoMorePhotos() {
        self.presentNoMorePhotosCalled = true
    }
    
    func presentPhotoDetailView(response: STPhotoCollection.PresentPhotoDetail.Response) {
        self.presentPhotoDetailViewCalled = true
    }
    
    func presentLoginView() {
        self.presentLoginViewCalled = true
    }
    
    func presentWillFetchImage(response: STPhotoCollection.FetchImage.Response) {
        self.presentWillFetchImageCalled = true
    }
    
    func presentDidFetchImage(response: STPhotoCollection.FetchImage.Response) {
        self.presentDidFetchImageCalled = true
    }
    
    func presentImage(response: STPhotoCollection.FetchImage.Response) {
        self.presentImageCalled = true
    }
}
