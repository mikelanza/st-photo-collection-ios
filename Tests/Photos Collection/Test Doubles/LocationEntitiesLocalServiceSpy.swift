//
//  LocationEntitiesLocalServiceSpy.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 13/09/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

@testable import STPhotoCollection
import STPhotoCore

class LocationEntitiesLocalTaskSpy: LocationEntitiesLocalTask {
    var fetchPhotoEntitiesCalled: Bool = false
    var shouldFailFetchPhotoEntities: Bool = false
    
    override func fetchPhotoEntities(location: STLocation, completionHandler: @escaping (Result<[EntityLevel : GeoEntity], OperationError>) -> Void) {
        self.fetchPhotoEntitiesCalled = true
        
        if self.shouldFailFetchPhotoEntities {
            completionHandler(Result.failure(OperationError.noDataAvailable))
        } else {
            completionHandler(Result.success([:]))
        }
    }
}
