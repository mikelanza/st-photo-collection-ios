//
//  STPhotoCollectionWorkerTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import XCTest
import STPhotoCore

class STPhotoCollectionWorkerTests: XCTestCase {
    var sut: STPhotoCollectionWorker!
    var delegateSpy: STPhotoCollectionWorkerDelegateSpy!
    
    override func setUp() {
        super.setUp()
        self.setupPhotoCollectionWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotoCollectionWorker() {
        self.delegateSpy = STPhotoCollectionWorkerDelegateSpy()
        self.sut = STPhotoCollectionWorker(delegate: self.delegateSpy)
    }
    
    // MARK: - Tests
    
    func testFetchImageForPhoto() {
        let taskSpy = ImageLocalTaskSpy()
        self.sut.imageTask = taskSpy
        self.sut.fetchImageFor(displayedPhoto: PhotoCollectionSeeds().getDisplayedPhoto())
        XCTAssertTrue(taskSpy.fetchImageCalled)
    }
    
    func testFetchImageForPhotoShouldAskTheDelegateToSendImageForSuccessCase() {
        let taskSpy = ImageLocalTaskSpy()
        taskSpy.shouldFailFetchImage = false
        self.sut.imageTask = taskSpy
        self.sut.fetchImageFor(displayedPhoto: PhotoCollectionSeeds().getDisplayedPhoto())
        XCTAssertTrue(self.delegateSpy.successDidFetchPhotoImageCalled)
    }
    
    func testFetchImageForPhotoShouldAskTheDelegateToSendErrorForFailureCase() {
        let taskSpy = ImageLocalTaskSpy()
        taskSpy.shouldFailFetchImage = true
        self.sut.imageTask = taskSpy
        self.sut.fetchImageFor(displayedPhoto: PhotoCollectionSeeds().getDisplayedPhoto())
        XCTAssertTrue(self.delegateSpy.failureDidFetchPhotoImageCalled)
    }
    
    func testFetchGeoEntity() {
        let taskSpy = LocationEntitiesLocalTaskSpy()
        self.sut.locationEntitiesTask = taskSpy
        self.sut.fetchGeoEntity(location: STLocation(latitude: 46, longitude: 25), entityLevel: EntityLevel(rawValue: "")!)
        XCTAssertTrue(taskSpy.fetchPhotoEntitiesCalled)
    }
    
    func testFetchGeoEntityShouldAskTheDelegateToSendGeoEntityForSuccessCase() {
        let taskSpy = LocationEntitiesLocalTaskSpy()
        taskSpy.shouldFailFetchPhotoEntities = false
        self.sut.locationEntitiesTask = taskSpy
        self.sut.fetchGeoEntity(location: STLocation(latitude: 46, longitude: 25), entityLevel: EntityLevel(rawValue: "")!)
        XCTAssertTrue(self.delegateSpy.successDidGetGeoEntityCalled)
    }
    
    func testFetchGeoEntityShouldAskTheDelegateToSendErrorForFailureCase() {
        let taskSpy = LocationEntitiesLocalTaskSpy()
        taskSpy.shouldFailFetchPhotoEntities = true
        self.sut.locationEntitiesTask = taskSpy
        self.sut.fetchGeoEntity(location: STLocation(latitude: 46, longitude: 25), entityLevel: EntityLevel(rawValue: "")!)
        XCTAssertTrue(self.delegateSpy.failureDidGetGeoEntityCalled)
    }
    
    func testFetchPhotos() {
        let taskSpy = PhotosLocalTaskSpy()
        self.sut.photosTask = taskSpy
        self.sut.fetchPhotos(model: PhotoCollectionSeeds().fetchPhotosModel())
        XCTAssertTrue(taskSpy.fetchPhotosCalled)
    }
    
    func testFetchPhotosShouldAskTheDelegateToSendPhotosForSuccessCase() {
        let taskSpy = PhotosLocalTaskSpy()
        taskSpy.shouldFailFetchPhotos = false
        self.sut.photosTask = taskSpy
        self.sut.fetchPhotos(model: PhotoCollectionSeeds().fetchPhotosModel())
        XCTAssertTrue(self.delegateSpy.successDidFetchPhotosCalled)
    }
    
    func testFetchPhotosShouldAskTheDelegateToSendErrorForFailureCase() {
        let taskSpy = PhotosLocalTaskSpy()
        taskSpy.shouldFailFetchPhotos = true
        self.sut.photosTask = taskSpy
        self.sut.fetchPhotos(model: PhotoCollectionSeeds().fetchPhotosModel())
        XCTAssertTrue(self.delegateSpy.failureDidFetchPhotosCalled)
    }
}

