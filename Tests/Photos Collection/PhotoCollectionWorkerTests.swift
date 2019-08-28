//
//  PhotoCollectionWorkerTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import XCTest

class PhotoCollectionWorkerTests: XCTestCase {
    var sut: PhotoCollectionWorker!
    
    override func setUp() {
        super.setUp()
        self.setupPhotoCollectionWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotoCollectionWorker() {
        self.sut = PhotoCollectionWorker(delegate: nil)
    }
    
    // MARK: - Tests
    
}

