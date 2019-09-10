//
//  STPhotoCollectionWorkerTests.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import XCTest

class STPhotoCollectionWorkerTests: XCTestCase {
    var sut: STPhotoCollectionWorker!
    
    override func setUp() {
        super.setUp()
        self.setupPhotoCollectionWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotoCollectionWorker() {
        self.sut = STPhotoCollectionWorker(delegate: nil)
    }
    
    // MARK: - Tests
    
}

