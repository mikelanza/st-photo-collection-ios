//
//  PhotosCollectionViewControllerTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import XCTest
import STPhotoCore

class PhotosCollectionViewControllerTests: XCTestCase {
    var sut: PhotosCollectionViewController!
    var interactorSpy: PhotosCollectionBusinessLogicSpy!
    var routerSpy: PhotosCollectionRoutingLogicSpy!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        self.setupPhotosCollectionViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotosCollectionViewController() {
        self.sut = PhotosCollectionViewController(model: PhotosCollectionSeeds().getPhotosCollectionModel())
        let _ = UINavigationController(rootViewController: self.sut)
        
        self.interactorSpy = PhotosCollectionBusinessLogicSpy()
        self.sut.interactor = self.interactorSpy
        
        self.routerSpy = PhotosCollectionRoutingLogicSpy()
        self.sut.router = self.routerSpy
    }
    
    func loadView() {
        self.window.addSubview(self.sut.view)
        RunLoop.current.run(until: Date())
    }
    
    private func waitForMainQueue() {
        let waitExpectation = expectation(description: "Waiting for main queue.")
        DispatchQueue.main.async {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Test doubles
    
    class CollectionViewSpy: UICollectionView {
        var reloadSectionsCalled: Bool = false
        var insertItemsCalled: Bool = false
        var reloadItemsCalled: Bool = false
        var deleteItemsCalled: Bool = false
        
        override func insertItems(at indexPaths: [IndexPath]) {
            self.insertItemsCalled = true
            super.insertItems(at: indexPaths)
        }
        
        override func reloadSections(_ sections: IndexSet) {
            self.reloadSectionsCalled = true
            super.reloadSections(sections)
        }
        
        override func reloadItems(at indexPaths: [IndexPath]) {
            self.reloadItemsCalled = true
            super.reloadItems(at: indexPaths)
        }
        
        override func deleteItems(at indexPaths: [IndexPath]) {
            self.deleteItemsCalled = true
            super.deleteItems(at: indexPaths)
        }
    }
    
    // MARK: - Tests
    
    func testAddBackButtonWhenViewDidLoad() {
        self.loadView()
        XCTAssertNotNil(self.sut.navigationItem.leftBarButtonItem)
    }
    
    // MARK: - Business tests
    
    func testShouldFetchEntityDetailsWhenTheViewDidLoad() {
        self.loadView()
        XCTAssertTrue(self.interactorSpy.shouldFetchEntityDetailsCalled)
    }
    
    func testShouldNotFetchNextEntityPhotosWhenScrollViewDidScrollWhenScrollIsNotDecelerating() {
        let scrollView = UIScrollView()
        scrollView.contentSize.height = 300
        scrollView.frame.size.height = 100
        self.sut.scrollViewDidScroll(scrollView)
        XCTAssertFalse(self.interactorSpy.shouldFetchNextEntityPhotosCalled)
    }
    
    func testShouldPresentPhoto() {
        self.loadView()
        self.sut.sections[self.sut.photosSectionIndex].items = [PhotosCollectionSeeds().getDisplayedPhoto()]
        let _ = self.sut.collectionView(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()), didSelectItemAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(self.interactorSpy.shouldPresentPhotoCalled)
    }
    
    func testShouldDownloadPhotoImage() {
        self.loadView()
        self.sut.sections[self.sut.photosSectionIndex].items = [PhotosCollectionSeeds().getDisplayedPhoto()]
        
        let _ = self.sut.collectionView(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()), cellForItemAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(self.interactorSpy.shouldDownloadPhotoCalled)
    }
    
    func testShouldSetPhotoItemSize() {
        self.loadView()
        XCTAssertTrue(self.interactorSpy.setPhotoItemSizeCalled)
    }
    
    // MARK: - Display logic
    
    func testDisplayEntityDetails() {
        self.loadView()
        
        let viewModel = PhotosCollection.PresentEntityDetails.ViewModel(title: "title", imageName: "block")
        self.sut.displayEntityDetails(viewModel: viewModel)
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.entityView.model.title, viewModel.title)
        XCTAssertEqual(self.sut.entityView.model.imageName, viewModel.imageName)
    }
    
    func testDisplayWillFetchEntityDetails() {
        self.loadView()

        self.sut.displayWillFetchEntityDetails()
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.entityView.model.isLoading)
    }

    func testDisplayDidFetchEntityDetails() {
        self.loadView()

        self.sut.displayDidFetchEntityDetails()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.entityView.model.isLoading)
    }

    func testDisplayWillFetchPhotos() {
        self.loadView()
        self.sut.displayWillFetchPhotos()
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[self.sut.photosSectionIndex].isLoading)
    }

    func testDisplayDidFetchPhotos() {
        self.loadView()
        self.sut.displayDidFetchPhotos()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[self.sut.photosSectionIndex].isLoading)
    }

    func testDisplayNoPhotos() {
        self.loadView()
        self.sut.displayNoPhotos()
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[self.sut.photosSectionIndex].noItems)
    }

    func testDisplayNoMorePhotos() {
        self.loadView()
        self.sut.displayNoMorePhotos()
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[self.sut.photosSectionIndex].noMoreItems)
    }

    func testDisplayPhotoDetailsView() {
        self.loadView()
        self.sut.displayPhotoDetailView(viewModel: PhotosCollection.PresentPhotoDetail.ViewModel(photo: STPhoto(id: "")))
        XCTAssertTrue(self.routerSpy.presentPhotoDetailViewCalled)
    }
    
    func testDisplayFetchedPhotosShouldUpdateModel() {
        self.loadView()
    
        let displayedPhotos = PhotosCollectionSeeds().getDisplayedPhotos()
        self.sut.displayFetchedPhotos(viewModel: PhotosCollection.FetchPhotos.ViewModel(displayedPhotos: displayedPhotos))
        self.waitForMainQueue()
        
        XCTAssertEqual(self.sut.sections[self.sut.photosSectionIndex].items.count, displayedPhotos.count)
    }
    
    func testDisplayFetchedPhotosShouldInsertItems() {
        self.loadView()

        let collectionViewSpy = CollectionViewSpy(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionViewSpy.dataSource = self.sut
        collectionViewSpy.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.defaultReuseIdentifier)
        self.sut.collectionView = collectionViewSpy

        self.sut.displayFetchedPhotos(viewModel: PhotosCollection.FetchPhotos.ViewModel(displayedPhotos: PhotosCollectionSeeds().getDisplayedPhotos()))
        self.waitForMainQueue()

        XCTAssertTrue(collectionViewSpy.insertItemsCalled)
    }
}
