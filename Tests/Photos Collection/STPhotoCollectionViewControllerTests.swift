//
//  STPhotoCollectionViewControllerTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import XCTest
import STPhotoCore

class STPhotoCollectionViewControllerTests: XCTestCase {
    var sut: STPhotoCollectionViewController!
    var interactorSpy: STPhotoCollectionBusinessLogicSpy!
    var routerSpy: STPhotoCollectionRoutingLogicSpy!
    
    var delegateSpy: STPhotoCollectionViewControllerDelegateSpy!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        self.setupPhotoCollectionViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotoCollectionViewController() {
        self.sut = STPhotoCollectionViewController(model: PhotoCollectionSeeds().getPhotosCollectionModel())
        let _ = UINavigationController(rootViewController: self.sut)
        
        self.interactorSpy = STPhotoCollectionBusinessLogicSpy()
        self.sut.interactor = self.interactorSpy
        
        self.routerSpy = STPhotoCollectionRoutingLogicSpy()
        self.sut.router = self.routerSpy
        
        self.delegateSpy = STPhotoCollectionViewControllerDelegateSpy()
        self.sut.delegate = self.delegateSpy
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
    
    func testDidTapBackButtonShouldRemoveViewController() {
        self.loadView()
    
        self.sut.didTapBackButton()
        XCTAssertTrue(self.routerSpy.removeViewControllerCalled)
    }
    
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
        self.sut.sections[self.sut.photosSectionIndex].items = [PhotoCollectionSeeds().getDisplayedPhoto()]
        let _ = self.sut.collectionView(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()), didSelectItemAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(self.interactorSpy.shouldPresentPhotoCalled)
    }
    
    func testShouldDownloadPhotoImage() {
        self.loadView()
        self.sut.sections[self.sut.photosSectionIndex].items = [PhotoCollectionSeeds().getDisplayedPhoto()]
        
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
        
        let viewModel = STPhotoCollection.PresentEntityDetails.ViewModel(title: "title", imageName: "block")
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

    func testDisplayPhotoDetailsViewShouldAskTheDelegateToSendNAvigateToPhotoDetailsForPhotoId() {
        self.loadView()
        self.sut.displayPhotoDetailView(viewModel: STPhotoCollection.PresentPhotoDetail.ViewModel(photo: STPhoto(id: "")))
        XCTAssertTrue(self.delegateSpy.photoCollectionViewControllerNavigateToPhotoDetailsForPhotoIdCalled)
    }
    
    func testDisplayFetchedPhotosShouldUpdateModel() {
        self.loadView()
    
        let displayedPhotos = PhotoCollectionSeeds().getDisplayedPhotos()
        self.sut.displayFetchedPhotos(viewModel: STPhotoCollection.FetchPhotos.ViewModel(displayedPhotos: displayedPhotos))
        self.waitForMainQueue()
        
        XCTAssertEqual(self.sut.sections[self.sut.photosSectionIndex].items.count, displayedPhotos.count)
    }
    
    func testDisplayFetchedPhotosShouldInsertItems() {
        self.loadView()

        let collectionViewSpy = CollectionViewSpy(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionViewSpy.dataSource = self.sut
        collectionViewSpy.register(STPhotoCollectionViewCell.self, forCellWithReuseIdentifier: STPhotoCollectionViewCell.defaultReuseIdentifier)
        self.sut.collectionView = collectionViewSpy

        self.sut.displayFetchedPhotos(viewModel: STPhotoCollection.FetchPhotos.ViewModel(displayedPhotos: PhotoCollectionSeeds().getDisplayedPhotos()))
        self.waitForMainQueue()

        XCTAssertTrue(collectionViewSpy.insertItemsCalled)
    }
}
