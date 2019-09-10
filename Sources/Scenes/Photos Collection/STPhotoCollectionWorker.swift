//
//  STPhotoCollectionWorker.swift
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

protocol STPhotoCollectionWorkerDelegate: class {
    func successDidGetGeoEntity(geoEntity: GeoEntity?)
    func failureDidGetGeoEntity(error: OperationError)
    
    func successDidFetchPhotoImage(displayedPhoto: STPhotoCollection.DisplayedPhoto?, image: UIImage?)
    func failureDidFetchPhotoImage(displayedPhoto: STPhotoCollection.DisplayedPhoto?, error: OperationError)
    
    func didFetchPhotos(photos: [STPhoto])
}

class STPhotoCollectionWorker {
    
    weak var delegate: STPhotoCollectionWorkerDelegate?
    
    var photosService: PhotosServiceProtocol = ServiceConfigurator.shared.photosService()
    var locationEntitiesService: LocationEntitiesServiceProtocol = ServiceConfigurator.shared.locationEntitiesService()
    var imageService: ImageServiceProtocol = ServiceConfigurator.shared.imageService()
    
    init(delegate: STPhotoCollectionWorkerDelegate?) {
        self.delegate = delegate
    }
    
    func fetchGeoEntity(location: STLocation, entityLevel: EntityLevel) {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
                
        self.locationEntitiesService.fetchPhotoEntities(location: location) { result in
            switch result {
            case .success(let entities): self.delegate?.successDidGetGeoEntity(geoEntity: entities[entityLevel]); break
            case .failure(let error): self.delegate?.failureDidGetGeoEntity(error: error); break
            }
        }
    }
    
    func fetchPhotos(model: FetchPhotosModel) {
        let entity = GetPhotosOperationModel.Entity(entityId: model.geoEntity.id, entityType: model.entityModel.level.rawValue)
        let filter = GetPhotosOperationModel.Filter(userId: model.filterModel.userId, collectionId: model.filterModel.collectionId)
        let entityFilter = GetPhotosOperationModel.EntityFilter(limit: model.limit, skip: model.skip, entity: entity, filter: filter)
        
        self.photosService.fetchPhotos(photoIds: nil, entityFilter: entityFilter, completionHandler: { result in
            switch result {
            case .success(let photos): self.delegate?.didFetchPhotos(photos: photos); break
            case .failure( _): break
            }
        })
    }
    
    func downloadPhotoFor(displayedPhoto: STPhotoCollection.DisplayedPhoto?) {
        self.imageService.fetchImage(url: displayedPhoto?.imageUrl) { result in
            switch result {
            case .success(let image): self.delegate?.successDidFetchPhotoImage(displayedPhoto: displayedPhoto, image: image); break
            case .failure(let error): self.delegate?.failureDidFetchPhotoImage(displayedPhoto: displayedPhoto, error: error); break
            }
        }
    }
}

// MARK: - Models

extension STPhotoCollectionWorker {
    struct FetchPhotosModel {
        let skip: Int
        let limit: Int
        let geoEntity: GeoEntity
        let entityModel: STPhotoCollection.EntityModel
        let filterModel: STPhotoCollection.FilterModel
    }
}