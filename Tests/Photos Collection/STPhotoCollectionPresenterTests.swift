//
//  STPhotoCollectionPresenterTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore
import XCTest

class STPhotoCollectionPresenterTests: XCTestCase {
    var sut: STPhotoCollectionPresenter!
    var displayerSpy: STPhotoCollectionDisplayLogicSpy!
    
    override func setUp() {
        super.setUp()
        self.setupPhotoCollectionPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotoCollectionPresenter() {
        self.sut = STPhotoCollectionPresenter()
        
        self.displayerSpy = STPhotoCollectionDisplayLogicSpy()
        self.sut.displayer = self.displayerSpy
    }
    
    // MARK: - Tests
    
    func testPresentFetchedPhotos(response: STPhotoCollection.FetchPhotos.Response) {
        self.sut.presentFetchedPhotos(response: STPhotoCollection.FetchPhotos.Response(photos: [], photoSize: CGSize()))
        XCTAssertTrue(self.displayerSpy.displayFetchedPhotosCalled)
    }
    
    func testPresentEntityDetails(response: STPhotoCollection.PresentEntityDetails.Response) {
        self.sut.presentEntityDetails(response: STPhotoCollection.PresentEntityDetails.Response(name: "", level: EntityLevel.block))
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
    
    func testPresentPhotoDetailView(response: STPhotoCollection.PresentPhotoDetail.Response) {
        self.sut.presentPhotoDetailView(response: STPhotoCollection.PresentPhotoDetail.Response(photo: STPhoto(id: "")))
        XCTAssertTrue(self.displayerSpy.displayPhotoDetailViewCalled)
    }
    
    // MARK: Fetch image
    
    func testPresentWillFetchImage() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        self.sut.presentWillFetchImage(response: STPhotoCollection.FetchImage.Response(displayedPhoto: displayedPhoto, image: nil))
        XCTAssertTrue(self.displayerSpy.displayWillFetchImageCalled)
    }
    
    func testPresentDidFetchImage() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        self.sut.presentDidFetchImage(response: STPhotoCollection.FetchImage.Response(displayedPhoto: displayedPhoto, image: nil))
        XCTAssertTrue(self.displayerSpy.displayDidFetchImageCalled)
    }
    
    func testPresentImage() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        self.sut.presentImage(response: STPhotoCollection.FetchImage.Response(displayedPhoto: displayedPhoto, image: UIImage()))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
}


