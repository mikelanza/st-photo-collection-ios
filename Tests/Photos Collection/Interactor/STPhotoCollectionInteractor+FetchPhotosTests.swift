//
//  STPhotoCollectionInteractor+FetchPhotos.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 13/09/2019.
//  Copyright © 2019 mikelanza. All rights reserved.
//

@testable import STPhotoCollection
import XCTest
import STPhotoCore

extension STPhotoCollectionInteractorTests {
    func testSuccessDidFetchPhotosShouldUpdatePhotosModel() {
        self.preconditionsForFetchPhotos()
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertNotEqual(self.sut.photos.count, 0)
    }
    
    func testSuccessDidFetchShouldAskThePresenterToPresentPhotos() {
        self.preconditionsForFetchPhotos()
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertTrue(self.presenterSpy.presentFetchedPhotosCalled)
    }
    
    func testSuccessDidFetchShouldUpdatePhotosPaginationModel() {
        self.preconditionsForFetchPhotos()
        let currentPage = self.sut.photosPaginationModel.currentPage
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertFalse(self.sut.photosPaginationModel.isFetchingItems)
        XCTAssertEqual(self.sut.photosPaginationModel.currentPage, currentPage + 1)
    }
    
    func testSuccessDidFetchShouldUpdatePhotosModelWhenDidFetchLastPhotos() {
        self.preconditionsForFetchPhotos()
        self.workerSpy.photos = [PhotoCollectionSeeds().getPhotos().first!]
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertNotEqual(self.sut.photos.count, 0)
    }
    
    func testSuccessDidFetchShouldAskThePresenterToPresentPhotosWhenDidFetchLastPhotos() {
        self.preconditionsForFetchPhotos()
        self.workerSpy.photos = []
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertTrue(self.presenterSpy.presentFetchedPhotosCalled)
    }
    
    
    func testSuccessDidFetchShouldAskThePresenterToPresentDidFetchPhotosWhenDidFetchLastPhotos() {
        self.preconditionsForFetchPhotos()
        self.workerSpy.photos = []
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertTrue(self.presenterSpy.presentDidFetchPhotosCalled)
    }
    
    func testSuccessDidFetchShouldUpdatePhotosPaginationModelWhenDidFetchLastPhotos() {
        self.preconditionsForFetchPhotos()
        self.workerSpy.photos = []
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertFalse(self.sut.photosPaginationModel.isFetchingItems)
        XCTAssertTrue(self.sut.photosPaginationModel.noMoreItems)
    }
    
    func testSuccessDidFetchShouldAskThePresenterToPresentNoMorePhotosWhenDidFetchLastPhotos() {
        self.preconditionsForFetchPhotos()
        self.workerSpy.photos = []
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertTrue(self.presenterSpy.presentNoMorePhotosCalled)
    }
    
    func testFailureDidFetchPhotosShouldAskThePresenterToPresentPhotos() {
        self.preconditionsForFetchPhotos()
        self.sut.failureDidFetchPhotos(error: .cannotParseResponse)
        
        XCTAssertTrue(self.presenterSpy.presentDidFetchPhotosCalled)
    }
    
    func preconditionsForFetchPhotos() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity(id: 1, name: "", level: .block)
    }
}
