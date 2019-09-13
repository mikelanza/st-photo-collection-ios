//
//  STPhotoCollectionSeeds.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 05/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore

struct PhotoCollectionSeeds {
    func getPhotosCollectionModel() -> STPhotoCollection.Model {
        let entityModel = STPhotoCollection.EntityModel(location: STLocation(latitude: 50.0, longitude: 50.0), level: .block)
        let filterModel = STPhotoCollection.FilterModel(userId: "userId", collectionId: "collectionId")
        return STPhotoCollection.Model(entityModel: entityModel, filterModel: filterModel)
    }
    
    func geoEntity(id: Int, name: String?, level: EntityLevel) -> GeoEntity {
        let boundingBox = BoundingBox(boundingCoordinates: (50, 50, 50, 50))
        var geoEntity = GeoEntity(id: id, boundingBox: boundingBox)
        geoEntity.name = name
        return geoEntity
    }
    
    func getPhotos() -> [STPhoto] {
        let first = STPhoto(id: "id1")
        let second = STPhoto(id: "id2")
        let third = STPhoto(id: "id3")
        return [first, second, third]
    }
    
    func getDisplayedPhoto() -> STPhotoCollection.DisplayedPhoto {
        let displayedPhoto = STPhotoCollection.DisplayedPhoto(id: "id1")
        displayedPhoto.imageUrl = "https://streetography.com"
        return displayedPhoto
    }
    
    func getDisplayedPhotos() -> [STPhotoCollection.DisplayedPhoto] {
        let first = STPhotoCollection.DisplayedPhoto(id: "id1")
        first.imageUrl = "https://streetography.com"
        
        let second = STPhotoCollection.DisplayedPhoto(id: "id2")
        second.imageUrl = "https://streetography.com"
        return [first, second]
    }
    
    func geoEntity() -> GeoEntity {
        return GeoEntity(id: 0, boundingBox: BoundingBox(boundingCoordinates: BoundingCoordinates(46,25,46,25)))
    }
    
    func fetchPhotosModel() -> STPhotoCollectionWorker.FetchPhotosModel {
        let geoEntity = GeoEntity(id: 0, boundingBox: BoundingBox(boundingCoordinates: BoundingCoordinates(46,25,46,25)))
        let entityModel = STPhotoCollection.EntityModel(location: STLocation(latitude: 46, longitude: 25), level: EntityLevel(rawValue: "")!)
        let filterModel = STPhotoCollection.FilterModel(userId: nil, collectionId: nil)
        return STPhotoCollectionWorker.FetchPhotosModel(skip: 0, limit: 0, geoEntity: geoEntity, entityModel: entityModel, filterModel: filterModel)
    }
}
