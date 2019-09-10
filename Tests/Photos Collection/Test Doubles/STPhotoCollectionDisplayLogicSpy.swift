//
//  STPhotoCollectionDisplayLogicSpy.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection

class STPhotoCollectionDisplayLogicSpy: NSObject, STPhotoCollectionDisplayLogic {
    var displayFetchedPhotosCalled: Bool = false
    var displayEntityDetailsCalled: Bool = false
    var displayWillFetchEntityDetailsCalled: Bool = false
    var displayDidFetchEntityDetailsCalled: Bool = false
    var displayWillFetchPhotosCalled: Bool = false
    var displayDidFetchPhotosCalled: Bool = false
    var displayNoPhotosCalled: Bool = false
    var displayNoMorePhotosCalled: Bool = false
    var displayPhotoDetailViewCalled: Bool = false
    var displayWillFetchImageCalled: Bool = false
    var displayDidFetchImageCalled: Bool = false
    var displayImageCalled: Bool = false
    
    func displayFetchedPhotos(viewModel: STPhotoCollection.FetchPhotos.ViewModel) {
        self.displayFetchedPhotosCalled = true
    }
    
    func displayEntityDetails(viewModel: STPhotoCollection.PresentEntityDetails.ViewModel) {
        self.displayEntityDetailsCalled = true
    }
    
    func displayWillFetchEntityDetails() {
        self.displayWillFetchEntityDetailsCalled = true
    }
    
    func displayDidFetchEntityDetails() {
        self.displayDidFetchEntityDetailsCalled = true
    }
    
    func displayWillFetchPhotos() {
        self.displayWillFetchPhotosCalled = true
    }
    
    func displayDidFetchPhotos() {
        self.displayDidFetchPhotosCalled = true
    }
    
    func displayNoPhotos() {
        self.displayNoPhotosCalled = true
    }
    
    func displayNoMorePhotos() {
        self.displayNoMorePhotosCalled = true
    }
    
    func displayPhotoDetailView(viewModel: STPhotoCollection.PresentPhotoDetail.ViewModel) {
        self.displayPhotoDetailViewCalled = true
    }
    
    func displayWillFetchImage(viewModel: STPhotoCollection.FetchImage.ViewModel) {
        self.displayWillFetchImageCalled = true
    }
    
    func displayDidFetchImage(viewModel: STPhotoCollection.FetchImage.ViewModel) {
        self.displayDidFetchImageCalled = true
    }
    
    func displayImage(viewModel: STPhotoCollection.FetchImage.ViewModel) {
        self.displayImageCalled = true
    }
}
