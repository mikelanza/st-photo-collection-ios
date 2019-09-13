//
//  STPhotoCollectionInteractor+FetchPhotos.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 13/09/2019.
//  Copyright © 2019 mikelanza. All rights reserved.
//

import UIKit
import STPhotoCore

extension STPhotoCollectionInteractor {
    func shouldFetchEntityPhotos() {
        if self.photosPaginationModel.noItems || self.photosPaginationModel.noMoreItems || self.photosPaginationModel.isFetchingItems {
            return
        }
        
        self.shouldFetchPhotos()
    }
    
    private func shouldFetchPhotos() {
        self.photosPaginationModel.isFetchingItems = true
        self.presenter?.presentWillFetchPhotos()
        
        if let workerModel = self.fetchPhotosWorkerModel() {
            self.worker?.fetchPhotos(model: workerModel)
        }
    }
    
    private func fetchPhotosWorkerModel() -> STPhotoCollectionWorker.FetchPhotosModel? {
        guard let model = self.model, let geoEntity = model.geoEntity else { return nil }
        let skip = self.photosPaginationModel.limit * self.photosPaginationModel.currentPage
        return STPhotoCollectionWorker.FetchPhotosModel(skip: skip, limit: self.photosPaginationModel.limit, geoEntity: geoEntity, entityModel: model.entityModel, filterModel: model.filterModel)
    }
    
    func successDidFetchPhotos(photos: [STPhoto]) {
        self.photos.append(contentsOf: photos)
        self.presentPhotos(photos: photos)
        self.photosPaginationModel.incrementCurrentPage()
        self.photosPaginationModel.isFetchingItems = false
        
        self.verifyLastPageOfPhotos(photoCount: photos.count)
    }
    
    func failureDidFetchPhotos(error: OperationError) {
        self.presenter?.presentDidFetchPhotos()
    }
    
    private func verifyLastPageOfPhotos(photoCount: Int) {
        guard photoCount < self.photosPaginationModel.limit else {
            return
        }
        self.photosPaginationModel.noMoreItems = true
        self.presenter?.presentDidFetchPhotos()
        self.presentEmptyStateIfNeeded(photoCount: photoCount)
    }
    
    private func presentEmptyStateIfNeeded(photoCount: Int) {
        if self.photos.count == 0 && photoCount == 0 {
            self.presenter?.presentNoMorePhotos()
        }
    }
    
    private func presentPhotos(photos: [STPhoto]) {
        let response = STPhotoCollection.FetchPhotos.Response(photos: photos, photoSize: self.photoItemSize)
        self.presenter?.presentFetchedPhotos(response: response)
    }
    
    private func presentNoPhotosIfNeeded() {
        if self.photosPaginationModel.noItems {
            self.presenter?.presentNoMorePhotos()
        }
    }
}
