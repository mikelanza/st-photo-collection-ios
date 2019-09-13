//
//  STPhotoCollectionInteractor+NextPhotosTests.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 13/09/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//


@testable import STPhotoCollection
import XCTest
import STPhotoCore

extension STPhotoCollectionInteractorTests {    
    func testShouldFetchNextEntityPhotosShouldNotAskTheWorkerToFetchPhotosWhenNoItems() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.photosPaginationModel.noItems = true
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchNextEntityPhotosShouldNotAskTheWorkerToFetchPhotosWhenNoMoreItems() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.photosPaginationModel.noMoreItems = true
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchNextEntityPhotosShouldNotAskTheWorkerToFetchPhotosWhenIsFechingItems() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.photosPaginationModel.isFetchingItems = true
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchNextEntityPhotosShouldFetchPhotosAndShouldAskToUpdatePaginationModel() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.workerSpy.delay = 0.1
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertTrue(self.sut.photosPaginationModel.isFetchingItems)
    }
    
    func testShouldFetchNextEntityPhotosShouldFetchPhotosAndShouldAskThePresenterToPresentWillFetchPhotos() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertTrue(self.presenterSpy.presentWillFetchPhotosCalled)
    }
    
    func testShouldFetchNextEntityPhotosShouldAskTheWorkerToFetchPhotos() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.shouldFetchNextEntityPhotos()
        
        XCTAssertTrue(self.workerSpy.fetchPhotosCalled)
    }
}
