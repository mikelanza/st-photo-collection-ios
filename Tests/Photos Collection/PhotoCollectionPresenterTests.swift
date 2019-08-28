//
//  PhotoCollectionPresenterTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore
import XCTest

class PhotoCollectionPresenterTests: XCTestCase {
    var sut: PhotoCollectionPresenter!
    var displayerSpy: PhotoCollectionDisplayLogicSpy!
    
    override func setUp() {
        super.setUp()
        self.setupPhotoCollectionPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotoCollectionPresenter() {
        self.sut = PhotoCollectionPresenter()
        
        self.displayerSpy = PhotoCollectionDisplayLogicSpy()
        self.sut.displayer = self.displayerSpy
    }
    
    // MARK: - Tests
    
    func testPresentFetchedPhotos(response: PhotoCollection.FetchPhotos.Response) {
        self.sut.presentFetchedPhotos(response: PhotoCollection.FetchPhotos.Response(photos: [], photoSize: CGSize()))
        XCTAssertTrue(self.displayerSpy.displayFetchedPhotosCalled)
    }
    
    func testPresentEntityDetails(response: PhotoCollection.PresentEntityDetails.Response) {
        self.sut.presentEntityDetails(response: PhotoCollection.PresentEntityDetails.Response(name: "", level: EntityLevel.block))
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
    
    func testPresentPhotoDetailView(response: PhotoCollection.PresentPhotoDetail.Response) {
        self.sut.presentPhotoDetailView(response: PhotoCollection.PresentPhotoDetail.Response(photo: STPhoto(id: "")))
        XCTAssertTrue(self.displayerSpy.displayPhotoDetailViewCalled)
    }
}


