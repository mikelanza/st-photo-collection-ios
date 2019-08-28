//
//  PhotoCollectionSeeds.swift
//  StreetographyTests
//
//  Created by Crasneanu Cristian on 05/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore

struct PhotoCollectionSeeds {
    func getPhotosCollectionModel() -> PhotoCollection.Model {
        let entityModel = PhotoCollection.EntityModel(location: STLocation(latitude: 50.0, longitude: 50.0), level: .block)
        let filterModel = PhotoCollection.FilterModel(userId: "userId", collectionId: "collectionId")
        return PhotoCollection.Model(entityModel: entityModel, filterModel: filterModel)
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
    
    func getDisplayedPhoto() -> PhotoCollection.DisplayedPhoto {
        let displayedPhoto = PhotoCollection.DisplayedPhoto(id: "id1")
        displayedPhoto.imageUrl = "https://streetography.com"
        return displayedPhoto
    }
    
    func getDisplayedPhotos() -> [PhotoCollection.DisplayedPhoto] {
        let first = PhotoCollection.DisplayedPhoto(id: "id1")
        first.imageUrl = "https://streetography.com"
        
        let second = PhotoCollection.DisplayedPhoto(id: "id2")
        second.imageUrl = "https://streetography.com"
        return [first, second]
    }
}
