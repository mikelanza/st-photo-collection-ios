//
//  STPhotoCollectionInteractor+ImageForPhoto.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 13/09/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//


@testable import STPhotoCollection
import XCTest
import STPhotoCore

extension STPhotoCollectionInteractorTests {
    func testShouldFetchImageForPhoto() {
        let request = STPhotoCollection.FetchImage.Request(displayedPhoto: PhotoCollectionSeeds().getDisplayedPhoto())
        self.sut.shouldFetchImageForPhoto(request: request)
        
        XCTAssertTrue(self.workerSpy.fetchImageForCalled)
    }
    
    func testShouldFetchImageForPhotoWhenImageIsLoading() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        displayedPhoto.isLoadingImage = true
        self.sut.shouldFetchImageForPhoto(request: STPhotoCollection.FetchImage.Request(displayedPhoto: displayedPhoto))
        
        XCTAssertFalse(self.workerSpy.fetchImageForCalled)
    }
    
    func testFetchImageForPhotoWhenImageIsAlreadyDownloaded() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        displayedPhoto.isLoadingImage = false
        displayedPhoto.image = UIImage()
        self.sut.shouldFetchImageForPhoto(request: STPhotoCollection.FetchImage.Request(displayedPhoto: displayedPhoto))
        
        XCTAssertFalse(self.workerSpy.fetchImageForCalled)
    }
    
    
    func testFetchImageForPhotoWhenThereIsNoUrl() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        displayedPhoto.isLoadingImage = false
        displayedPhoto.image = nil
        displayedPhoto.imageUrl = nil
        self.sut.shouldFetchImageForPhoto(request: STPhotoCollection.FetchImage.Request(displayedPhoto: displayedPhoto))
        
        XCTAssertFalse(self.workerSpy.fetchImageForCalled)
    }
    
    func testFetchImageForPhotoWhenImageIsNotDownloadedAndThereIsUrlAskThePresenterToPresentWillFetchImage() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        displayedPhoto.isLoadingImage = false
        displayedPhoto.image = nil
        self.sut.shouldFetchImageForPhoto(request: STPhotoCollection.FetchImage.Request(displayedPhoto: displayedPhoto))
        
        XCTAssertTrue(self.presenterSpy.presentWillFetchImageCalled)
    }
    
    func testFetchImageForPhotoWhenImageIsNotDownloadedAndThereIsUrlShouldAskTheWorkerToFetchImage() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        displayedPhoto.isLoadingImage = false
        displayedPhoto.image = nil
        self.sut.shouldFetchImageForPhoto(request: STPhotoCollection.FetchImage.Request(displayedPhoto: displayedPhoto))
        
        XCTAssertTrue(self.workerSpy.fetchImageForCalled)
    }
    
    func testFetchImageForPhotoWhenImageIsNotDownloadedAndThereIsNoUrlShouldAskThePresnterToPresentNoImage() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        displayedPhoto.isLoadingImage = false
        displayedPhoto.image = nil
        displayedPhoto.imageUrl = nil
        self.sut.shouldFetchImageForPhoto(request: STPhotoCollection.FetchImage.Request(displayedPhoto: displayedPhoto))
        
        XCTAssertFalse(self.workerSpy.fetchImageForCalled)
        XCTAssertTrue(self.presenterSpy.presentImageCalled)
    }
    
    func testSuccessDidFetchImageShouldAskThePresenterToPresentDidFetchImage() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        displayedPhoto.isLoadingImage = false
        displayedPhoto.image = nil
        self.sut.successDidFetchPhotoImage(displayedPhoto: displayedPhoto, image: UIImage())
        
        XCTAssertTrue(self.presenterSpy.presentDidFetchImageCalled)
    }
    
    func testSuccessDidFetchImageShouldAskThePresenterToPresentImage() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        displayedPhoto.isLoadingImage = false
        displayedPhoto.image = nil
        self.sut.successDidFetchPhotoImage(displayedPhoto: displayedPhoto, image: UIImage())
        
        XCTAssertTrue(self.presenterSpy.presentImageCalled)
    }
    
    func testFailureDidFetchImageShouldAskThePresenterToPresentDidFetchImage() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        displayedPhoto.isLoadingImage = false
        displayedPhoto.image = nil
        self.sut.failureDidFetchPhotoImage(displayedPhoto: displayedPhoto, error: .cannotParseResponse)
        
        XCTAssertTrue(self.presenterSpy.presentDidFetchImageCalled)
    }
    
    func testFailureDidFetchImageShouldAskThePresenterToPresentImage() {
        let displayedPhoto = PhotoCollectionSeeds().getDisplayedPhoto()
        displayedPhoto.isLoadingImage = false
        displayedPhoto.image = nil
        self.sut.failureDidFetchPhotoImage(displayedPhoto: displayedPhoto, error: .cannotParseResponse)
        
        XCTAssertTrue(self.presenterSpy.presentImageCalled)
    }
}
