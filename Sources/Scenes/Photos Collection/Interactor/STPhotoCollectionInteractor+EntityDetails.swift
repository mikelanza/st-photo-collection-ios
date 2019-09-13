//
//  STPhotoCollectionInteractor+EntityDetails.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 13/09/2019.
//  Copyright © 2019 mikelanza. All rights reserved.
//

import UIKit
import STPhotoCore

extension STPhotoCollectionInteractor {
    public func shouldFetchEntityDetails() {
        self.presentEntityDetails()
        self.fetchGeoEntity()
    }
    
    private func fetchGeoEntity() {
        guard let model = self.model else { return }
        
        self.presenter?.presentWillFetchEntityDetails()
        self.worker?.fetchGeoEntity(location: model.entityModel.location, entityLevel: model.entityModel.level)
    }
    
    private func presentEntityDetails() {
        guard let model = self.model else { return }
        
        let response = STPhotoCollection.PresentEntityDetails.Response(name: model.geoEntity?.name, level: model.entityModel.level)
        self.presenter?.presentEntityDetails(response: response)
    }
    
    func successDidGetGeoEntity(geoEntity: GeoEntity?) {
        guard let entity = geoEntity else {
            self.presenter?.presentNoPhotos()
            self.presenter?.presentDidFetchEntityDetails()
            self.photosPaginationModel.noItems = true
            return
        }
        
        self.model?.geoEntity = entity
        self.presentEntityDetails()
        self.shouldFetchEntityPhotos()
    }
    
    func failureDidGetGeoEntity(error: OperationError) {
        self.presenter?.presentNoPhotos()
        self.presenter?.presentDidFetchEntityDetails()
        self.photosPaginationModel.noItems = true
    }
}
