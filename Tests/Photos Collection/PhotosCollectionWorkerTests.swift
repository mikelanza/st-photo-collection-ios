//
//  PhotosCollectionWorkerTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import XCTest

class PhotosCollectionWorkerTests: XCTestCase {
    var sut: PhotosCollectionWorker!
    
    override func setUp() {
        super.setUp()
        self.setupPhotosCollectionWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotosCollectionWorker() {
        self.sut = PhotosCollectionWorker(delegate: nil)
    }
    
    // MARK: - Tests
    
}

