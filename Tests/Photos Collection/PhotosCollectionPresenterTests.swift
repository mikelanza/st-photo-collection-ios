//
//  PhotosCollectionPresenterTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore
import XCTest

class PhotosCollectionPresenterTests: XCTestCase {
    var sut: PhotosCollectionPresenter!
    var displayerSpy: PhotosCollectionDisplayLogicSpy!
    
    override func setUp() {
        super.setUp()
        self.setupPhotosCollectionPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotosCollectionPresenter() {
        self.sut = PhotosCollectionPresenter()
        
        self.displayerSpy = PhotosCollectionDisplayLogicSpy()
        self.sut.displayer = self.displayerSpy
    }
    
    // MARK: - Tests
    
    func testPresentFetchedPhotos(response: PhotosCollection.FetchPhotos.Response) {
        self.sut.presentFetchedPhotos(response: PhotosCollection.FetchPhotos.Response(photos: [], photoSize: CGSize()))
        XCTAssertTrue(self.displayerSpy.displayFetchedPhotosCalled)
    }
    
    func testPresentEntityDetails(response: PhotosCollection.PresentEntityDetails.Response) {
        self.sut.presentEntityDetails(response: PhotosCollection.PresentEntityDetails.Response(name: "", level: EntityLevel.block))
        XCTAssertTrue(self.displayerSpy.displayWillFetchEntityDetailsCalled)
    }
    
    func testPresentWillFetchEntityDetails() {
        self.sut.presentWillFetchEntityDetails()
        XCTAssertTrue(self.displayerSpy.displayWillFetchEntityDetailsCalled)
    }
    
    func testPresentDidFetchEntityDetails() {
        self.sut.presentDidFetchEntityDetails()
        XCTAssertTrue(self.displayerSpy.displayDidFetchEntityDetailsCalled)
    }
    
    func testPresentWillFetchPhotos() {
        self.sut.presentWillFetchPhotos()
        XCTAssertTrue(self.displayerSpy.displayWillFetchPhotosCalled)
    }
    
    func testPresentDidFetchPhotos() {
        self.sut.presentDidFetchPhotos()
        XCTAssertTrue(self.displayerSpy.displayDidFetchPhotosCalled)
    }
    
    func testPresentNoPhotos() {
        self.sut.presentNoPhotos()
        XCTAssertTrue(self.displayerSpy.displayNoPhotosCalled)
    }
    
    func testPresentNoMorePhotos() {
        self.sut.presentNoMorePhotos()
        XCTAssertTrue(self.displayerSpy.displayNoMorePhotosCalled)
    }
    
    func testPresentPhotoDetailView(response: PhotosCollection.PresentPhotoDetail.Response) {
        self.sut.presentPhotoDetailView(response: PhotosCollection.PresentPhotoDetail.Response(photo: STPhoto(id: "")))
        XCTAssertTrue(self.displayerSpy.displayPhotoDetailViewCalled)
    }
}


