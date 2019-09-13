//
//  STPhotoCollectionInteractor.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 08/08/2017.
//  Copyright (c) 2017 Streetography. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import STPhotoCore

protocol STPhotoCollectionBusinessLogic {
    func shouldFetchEntityDetails()
    
    func shouldFetchNextEntityPhotos()
    
    func shouldPresentPhoto(request: STPhotoCollection.PresentPhoto.Request)
    
    func shouldFetchImageForPhoto(request: STPhotoCollection.FetchImage.Request)
    
    func setModel(model: STPhotoCollection.Model)
    func setPhotoItemSize(size: CGSize)
}

protocol STPhotoCollectionDataStore {
    var photos: [STPhoto] { get set }
    
    var model: STPhotoCollection.Model? { get set }
    
    var photoItemSize: CGSize { get set }
}

class STPhotoCollectionInteractor: STPhotoCollectionBusinessLogic, STPhotoCollectionDataStore, STPhotoCollectionWorkerDelegate {
    var presenter: STPhotoCollectionPresentationLogic?
    var worker: STPhotoCollectionWorker?
    
    var photos: [STPhoto] = []
    var model: STPhotoCollection.Model?
    var photoItemSize: CGSize = CGSize.zero
    var photosPaginationModel: STPhotoCollection.PaginationModel
    
    init() {
        self.photosPaginationModel = STPhotoCollection.PaginationModel(isFetchingItems: false, noMoreItems: false, noItems: false, limit: 30, currentPage: 0)
        self.worker = STPhotoCollectionWorker(delegate: self)
    }
    
    func setModel(model: STPhotoCollection.Model) {
        self.model = model
    }
    
    func setPhotoItemSize(size: CGSize) {
        self.photoItemSize = size
    }
    
    func shouldPresentPhoto(request: STPhotoCollection.PresentPhoto.Request) {
        if let photo = self.photoForId(photoId: request.photoId) {
            self.presentPhotoDetailFor(photo: photo)
        }
    }
    
    private func presentPhotoDetailFor(photo: STPhoto) {
        let response = STPhotoCollection.PresentPhotoDetail.Response(photoId: photo.id)
        self.presenter?.presentPhotoDetailView(response: response)
    }
    
    private func photoForId(photoId: String?) -> STPhoto? {
        return self.photos.filter({ $0.id == photoId }).first
    }
}

