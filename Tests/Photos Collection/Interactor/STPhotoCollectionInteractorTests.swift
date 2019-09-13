//
//  STPhotoCollectionInteractorTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import XCTest
import STPhotoCore

class STPhotoCollectionInteractorTests: XCTestCase {
    var sut: STPhotoCollectionInteractor!
    var presenterSpy: STPhotoCollectionPresentationLogicSpy!
    var workerSpy: STPhotoCollectionWorkerSpy!
    
    override func setUp() {
        super.setUp()
        self.setupPhotoCollectionInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotoCollectionInteractor() {
        self.sut = STPhotoCollectionInteractor()
        
        self.presenterSpy = STPhotoCollectionPresentationLogicSpy()
        self.sut.presenter = self.presenterSpy
        
        self.workerSpy = STPhotoCollectionWorkerSpy(delegate: self.sut)
        self.sut.worker = self.workerSpy
    }
    
    // MARK: - Tests
    
    func testSetModel() {
        let model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.setModel(model: model)
        
        XCTAssertEqual(self.sut.model?.entityModel.location, model.entityModel.location)
        XCTAssertEqual(self.sut.model?.entityModel.level, model.entityModel.level)
        XCTAssertEqual(self.sut.model?.filterModel.userId, model.filterModel.userId)
        XCTAssertEqual(self.sut.model?.filterModel.collectionId, model.filterModel.collectionId)
    }
    
    func testSetPhotoItemSize() {
        let size = CGSize(width: 100, height: 100)
        self.sut.setPhotoItemSize(size: size)
        XCTAssertEqual(self.sut.photoItemSize, size)
    }
    
    func testShouldPresentPhoto() {
        self.sut.photos = PhotoCollectionSeeds().getPhotos()
        self.sut.shouldPresentPhoto(request: STPhotoCollection.PresentPhoto.Request(photoId: PhotoCollectionSeeds().getPhotos().first?.id))
        XCTAssertTrue(self.presenterSpy.presentPhotoDetailViewCalled)
    }
}


