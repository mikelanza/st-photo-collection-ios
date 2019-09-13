//
//  STPhotoInteractor+GeoEntityTests.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 13/09/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import XCTest
import STPhotoCore

extension STPhotoCollectionInteractorTests {
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentEntityDetails() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.shouldFetchEntityDetails()
        
        XCTAssertTrue(self.presenterSpy.presentEntityDetailsCalled)
    }
    
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentWillFetchEntityDetails() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.shouldFetchEntityDetails()
        
        XCTAssertTrue(self.presenterSpy.presentWillFetchEntityDetailsCalled)
    }
    
    func testShouldFetchEntityDetailsShouldAskWorkerToFetchGeoEntity() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.shouldFetchEntityDetails()
        
        XCTAssertTrue(self.workerSpy.fetchGeoEntityCalled)
    }
    
    func testSuccessDidGetGeoEntityShouldAskPresenterToPresentNoPhotosWhenNoEntity() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = nil
        self.sut.successDidGetGeoEntity(geoEntity: nil)
        
        XCTAssertTrue(self.presenterSpy.presentNoPhotosCalled)
    }
    
    func testSuccessDidGetGeoEntityShouldAskPresenterToPresentDidFetchEntityDetailsWhenNoEntity() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = nil
        self.sut.successDidGetGeoEntity(geoEntity: nil)
        
        XCTAssertTrue(self.presenterSpy.presentDidFetchEntityDetailsCalled)
    }
    
    func testSuccessDidGetGeoEntityShouldUpdatePhotosPaginationModelWhenNoEntity() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = nil
        self.sut.successDidGetGeoEntity(geoEntity: nil)
        
        XCTAssertTrue(self.sut.photosPaginationModel.noItems)
    }
    
    func testSuccessDidGetGeoEntityShouldAskToUpdateModel() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = nil
        let geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.successDidGetGeoEntity(geoEntity: geoEntity)
        
        XCTAssertNotNil(self.sut.model?.geoEntity)
        XCTAssertEqual(self.sut.model?.geoEntity?.id, geoEntity.id)
        XCTAssertEqual(self.sut.model?.geoEntity?.entityLevel, geoEntity.entityLevel)
    }
    
    func testSuccessDidGetGeoEntityShouldAskPresenterToPresentEntityDetails() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = nil
        self.sut.successDidGetGeoEntity(geoEntity: PhotoCollectionSeeds().geoEntity())
        
        XCTAssertTrue(self.presenterSpy.presentEntityDetailsCalled)
    }
    
    func testSuccessDidGetGeoEntityShouldNotAskTheWorkerToFetchPhotosWhenNoItems() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.photosPaginationModel.noItems = true
        self.sut.successDidGetGeoEntity(geoEntity: PhotoCollectionSeeds().geoEntity())
        
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testSuccessDidGetGeoEntityShouldNotAskTheWorkerToFetchPhotosWhenNoMoreItems() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.photosPaginationModel.noMoreItems = true
        self.sut.successDidGetGeoEntity(geoEntity: PhotoCollectionSeeds().geoEntity())
        
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testSuccessDidGetGeoEntityShouldNotAskTheWorkerToFetchPhotosWhenIsFechingItems() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.photosPaginationModel.isFetchingItems = true
        self.sut.successDidGetGeoEntity(geoEntity: PhotoCollectionSeeds().geoEntity())
        
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testSuccessDidGetGeoEntityShouldFetchPhotosAndShouldAskToUpdatePaginationModel() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.workerSpy.delay = 0.1
        self.sut.successDidGetGeoEntity(geoEntity: PhotoCollectionSeeds().geoEntity())
        
        XCTAssertTrue(self.sut.photosPaginationModel.isFetchingItems)
    }
    
    func testSuccessDidGetGeoEntityShouldFetchPhotosAndShouldAskThePresenterToPresentWillFetchPhotos() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.successDidGetGeoEntity(geoEntity: PhotoCollectionSeeds().geoEntity())
        
        XCTAssertTrue(self.presenterSpy.presentWillFetchPhotosCalled)
    }
    
    func testSuccessDidGetGeoEntityShouldAskTheWorkerToFetchPhotos() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotoCollectionSeeds().geoEntity()
        self.sut.successDidGetGeoEntity(geoEntity: PhotoCollectionSeeds().geoEntity())
        
        XCTAssertTrue(self.workerSpy.fetchPhotosCalled)
    }
    
    func testFailureDidGetGeoEntityShouldAskPresenterToPresentNoPhotos() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = nil
        self.sut.failureDidGetGeoEntity(error: OperationError.cannotParseResponse)
        
        XCTAssertTrue(self.presenterSpy.presentNoPhotosCalled)
    }
    
    func testFailureDidGetGeoEntityShouldAskPresenterToPresentDidFetchEntityDetails() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = nil
        self.sut.failureDidGetGeoEntity(error: OperationError.cannotParseResponse)
        
        XCTAssertTrue(self.presenterSpy.presentDidFetchEntityDetailsCalled)
    }
    
    func testFailureDidGetGeoEntityShouldUpdatePhotosPaginationModel() {
        self.sut.model = PhotoCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = nil
        self.sut.failureDidGetGeoEntity(error: OperationError.cannotParseResponse)
        
        XCTAssertTrue(self.sut.photosPaginationModel.noItems)
    }
}
