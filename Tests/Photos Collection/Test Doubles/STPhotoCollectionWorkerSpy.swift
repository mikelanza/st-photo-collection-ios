//
//  STPhotoCollectionWorkerSpy.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore

class STPhotoCollectionWorkerSpy: STPhotoCollectionWorker {
    var delay: Double = 0
    
    var fetchGeoEntityCalled: Bool = false
    var fetchPhotosCalled: Bool = false
    var fetchImageForCalled: Bool = false
    
    var geoEntity: GeoEntity? = PhotoCollectionSeeds().geoEntity(id: 10, name: "name", level: .block)
    
    var photos: [STPhoto] = PhotoCollectionSeeds().getPhotos()
    
    var shouldFailFetchGeoEntity: Bool = false
    
    override func fetchGeoEntity(location: STLocation, entityLevel: EntityLevel) {
        self.fetchGeoEntityCalled = true
        
        if self.delay == 0 {
            self.didFetchGeoEntity()
        } else {
            DispatchQueue.global().asyncAfter(deadline: .now() + self.delay) {
                self.didFetchGeoEntity()
            }
        }
    }
    
    override func fetchPhotos(model: FetchPhotosModel) {
        self.fetchPhotosCalled = true
        
        if self.delay == 0 {
             self.delegate?.successDidFetchPhotos(photos: self.photos)
        } else {
            DispatchQueue.global().asyncAfter(deadline: .now() + self.delay) {
                 self.delegate?.successDidFetchPhotos(photos: self.photos)
            }
        }
    }
    
    override func fetchImageFor(displayedPhoto: STPhotoCollection.DisplayedPhoto) {
        self.fetchImageForCalled = true
    }
    
    private func didFetchGeoEntity() {
        if self.shouldFailFetchGeoEntity {
            self.delegate?.failureDidGetGeoEntity(error: OperationError.noDataAvailable)
        } else {
            self.delegate?.successDidGetGeoEntity(geoEntity: self.geoEntity)
        }
    }
}
