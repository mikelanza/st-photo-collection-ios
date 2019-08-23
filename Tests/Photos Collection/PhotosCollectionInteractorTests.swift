//
//  PhotosCollectionInteractorTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import XCTest
import STPhotoCore

class PhotosCollectionInteractorTests: XCTestCase {
    var sut: PhotosCollectionInteractor!
    var presenterSpy: PhotosCollectionPresentationLogicSpy!
    var workerSpy: PhotosCollectionWorkerSpy!
    
    override func setUp() {
        super.setUp()
        self.setupPhotosCollectionInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotosCollectionInteractor() {
        self.sut = PhotosCollectionInteractor()
        
        self.presenterSpy = PhotosCollectionPresentationLogicSpy()
        self.sut.presenter = self.presenterSpy
        
        self.workerSpy = PhotosCollectionWorkerSpy(delegate: self.sut)
        self.sut.worker = self.workerSpy
    }
    
    // MARK: - Tests
    
    func testSetModel() {
        
        let model = PhotosCollectionSeeds().getPhotosCollectionModel()
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
    
    // MARK: Fetch entity
    
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentEntityDetails() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentEntityDetailsCalled)
    }
    
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentWillFetchEntityDetails() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentWillFetchEntityDetailsCalled)
    }
    
    func testShouldFetchEntityDetailsShouldAskWorkerToFetchGeoEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.workerSpy.fetchGeoEntityCalled)
    }
    
    func testShouldFetchEntityDetailsShouldUpdateGeoEntityModelWhenSuccessDidGetGeoEntityWithEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertNotNil(self.sut.model?.geoEntity)
    }
    
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentEntityDetailsWhenSuccessDidGetGeoEntityWithEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentEntityDetailsCalled)
    }
    
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentNoPhotosWhenSuccessDidGetGeoEntityWithNoEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.workerSpy.geoEntity = nil
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentNoPhotosCalled)
    }
    
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentDidFetchEntityDetailsWhenSuccessDidGetGeoEntityWithNoEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.workerSpy.geoEntity = nil
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentDidFetchEntityDetailsCalled)
    }
    
    func testShouldFetchEntityDetailsShouldUpdatePhotosPaginationModelWhenSuccessDidGetGeoEntityWithNoEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.workerSpy.geoEntity = nil
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.sut.photosPaginationModel.noItems)
    }
    
    func testShouldFetchEntityDetailsShouldUpdatePhotosPaginationModelWhenServerErrorDidGetGeoEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.workerSpy.shouldFailFetchGeoEntity = true
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.sut.photosPaginationModel.noItems)
    }
    
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentNoPhotosWhenServerErrorDidGetGeoEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.workerSpy.shouldFailFetchGeoEntity = true
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentNoPhotosCalled)
    }
    
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentDidFetchEntityDetailsWhenServerErrorDidGetGeoEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.workerSpy.shouldFailFetchGeoEntity = true
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentDidFetchEntityDetailsCalled)
    }
    
    func testShouldFetchEntityDetailsShouldUpdatePhotosPaginationModelWhenOperationErrorDidGetGeoEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.workerSpy.shouldFailFetchGeoEntity = true
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.sut.photosPaginationModel.noItems)
    }
    
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentNoPhotosWhenOperationErrorDidGetGeoEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.workerSpy.shouldFailFetchGeoEntity = true
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentNoPhotosCalled)
    }
    
    func testShouldFetchEntityDetailsShouldAskPresenterToPresentDidFetchEntityDetailsWhenOperationErrorDidGetGeoEntity() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.workerSpy.shouldFailFetchGeoEntity = true
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentDidFetchEntityDetailsCalled)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosWhenIsFetchingEntityPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        self.sut.photosPaginationModel.isFetchingItems = true
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosWhenNoItems() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        self.sut.photosPaginationModel.noItems = true
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosWhenNoMoreItems() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        self.sut.photosPaginationModel.noMoreItems = true
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldUpdateIsFetchingItemsModel() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        self.workerSpy.delay = 0.1
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.sut.photosPaginationModel.isFetchingItems)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldAskThePresenterToPresentWillFetchPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentWillFetchPhotosCalled)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldAskTheWorkerToFetchPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldUpdatePhotosModelWhenSuccessDidFetchPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertNotEqual(self.sut.photos.count, 0)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldAskThePresenterToPresentPhotosWhenSuccessDidFetchPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentFetchedPhotosCalled)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldUpdatePhotosPaginationModelWhenSuccessDidFetchPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        let currentPage = self.sut.photosPaginationModel.currentPage
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertFalse(self.sut.photosPaginationModel.isFetchingItems)
        XCTAssertEqual(self.sut.photosPaginationModel.currentPage, currentPage + 1)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldUpdatePhotosModelWhenSuccessDidFetchLastPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        self.workerSpy.photos = [PhotosCollectionSeeds().getPhotos().first!]
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertNotEqual(self.sut.photos.count, 0)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldAskThePresenterToPresentPhotosWhenSuccessDidFetchLastPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        
        self.workerSpy.photos = []
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentFetchedPhotosCalled)
    }
    
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldAskThePresenterToPresentDidFetchPhotosWhenSuccessDidFetchLastPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        self.workerSpy.photos = []
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentDidFetchPhotosCalled)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldUpdatePhotosPaginationModelWhenSuccessDidFetchLastPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        self.workerSpy.photos = []
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertFalse(self.sut.photosPaginationModel.isFetchingItems)
        XCTAssertTrue(self.sut.photosPaginationModel.noMoreItems)
    }
    
    func testShouldFetchEntityDetailsAndShouldFetchPhotosShouldAskThePresenterToPresentNoMorePhotosWhenSuccessDidFetchLastPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        self.workerSpy.photos = []
        
        self.sut.shouldFetchEntityDetails()
        XCTAssertTrue(self.presenterSpy.presentNoMorePhotosCalled)
    }
    
    func testShouldPresentPhoto() {
        self.sut.photos = PhotosCollectionSeeds().getPhotos()
        self.sut.shouldPresentPhoto(request: PhotosCollection.PresentPhoto.Request(photoId: PhotosCollectionSeeds().getPhotos().first?.id))
        XCTAssertTrue(self.presenterSpy.presentPhotoDetailViewCalled)
    }
    
    func testShouldDownloadPhoto() {
        let request = PhotosCollection.DownloadPhoto.Request(displayedPhoto: PhotosCollectionSeeds().getDisplayedPhoto())
        self.sut.shouldDownloadPhoto(request: request)
        XCTAssertTrue(self.workerSpy.downloadPhotoForCalled)
    }
    
    // MARK: Fetch photos
    
    func testShouldFetchNextEntityPhotosWhenIsFetchingEntityPhotos() {
        self.sut.photosPaginationModel.isFetchingItems = true
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchNextEntityPhotosWhenNoItems() {
        self.sut.photosPaginationModel.noItems = true
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchNextEntityPhotosWhenNoMoreItems() {
        self.sut.photosPaginationModel.noMoreItems = true
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertFalse(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchNextEntityShouldUpdateIsFetchingItemsModel() {
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertTrue(self.sut.photosPaginationModel.isFetchingItems)
    }
    
    func testShouldFetchNextEntityShouldAskThePresenterToPresentWillFetchPhotos() {
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertTrue(self.presenterSpy.presentWillFetchPhotosCalled)
    }
    
    func testShouldFetchNextEntityShouldAskTheWorkerToFetchPhotos() {
        self.preconditionsForFetchPhotos()
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertTrue(self.workerSpy.fetchPhotosCalled)
    }
    
    func testShouldFetchNextEntityShouldUpdatePhotosModelWhenSuccessDidFetchPhotos() {
        self.preconditionsForFetchPhotos()
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertNotEqual(self.sut.photos.count, 0)
    }
    
    func testShouldFetchNextEntityShouldAskThePresenterToPresentPhotosWhenSuccessDidFetchPhotos() {
        self.preconditionsForFetchPhotos()
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertTrue(self.presenterSpy.presentFetchedPhotosCalled)
    }
    
    func testShouldFetchNextEntityShouldUpdatePhotosPaginationModelWhenSuccessDidFetchPhotos() {
        self.preconditionsForFetchPhotos()
        
        let currentPage = self.sut.photosPaginationModel.currentPage
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertFalse(self.sut.photosPaginationModel.isFetchingItems)
        XCTAssertEqual(self.sut.photosPaginationModel.currentPage, currentPage + 1)
    }
    
    func testShouldFetchNextEntityShouldUpdatePhotosModelWhenSuccessDidFetchLastPhotos() {
        self.preconditionsForFetchPhotos()
        self.workerSpy.photos = [PhotosCollectionSeeds().getPhotos().first!]
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertNotEqual(self.sut.photos.count, 0)
    }
    
    func testShouldFetchNextEntityShouldAskThePresenterToPresentPhotosWhenSuccessDidFetchLastPhotos() {
        self.preconditionsForFetchPhotos()
        
        self.workerSpy.photos = []
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertTrue(self.presenterSpy.presentFetchedPhotosCalled)
    }
    
    
    func testShouldFetchNextEntityShouldAskThePresenterToPresentDidFetchPhotosWhenSuccessDidFetchLastPhotos() {
        self.preconditionsForFetchPhotos()
        self.workerSpy.photos = []
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertTrue(self.presenterSpy.presentDidFetchPhotosCalled)
    }
    
    func testShouldFetchNextEntityShouldUpdatePhotosPaginationModelWhenSuccessDidFetchLastPhotos() {
        self.preconditionsForFetchPhotos()
        self.workerSpy.photos = []
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertFalse(self.sut.photosPaginationModel.isFetchingItems)
        XCTAssertTrue(self.sut.photosPaginationModel.noMoreItems)
    }
    
    func testShouldFetchNextEntityShouldAskThePresenterToPresentNoMorePhotosWhenSuccessDidFetchLastPhotos() {
        self.preconditionsForFetchPhotos()
        self.workerSpy.photos = []
        
        self.sut.shouldFetchNextEntityPhotos()
        XCTAssertTrue(self.presenterSpy.presentNoMorePhotosCalled)
    }
    
    private func preconditionsForFetchPhotos() {
        self.sut.model = PhotosCollectionSeeds().getPhotosCollectionModel()
        self.sut.model?.geoEntity = PhotosCollectionSeeds().geoEntity(id: 1, name: "", level: .block)
    }
}


