//
//  ServiceConfigurator.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 05/08/2019.
//  Copyright © 2019 mikelanza. All rights reserved.
//

import Foundation

class ServiceConfigurator {
    static let shared = ServiceConfigurator()
    
    private init() { }
    
    func imageService() -> ImageServiceProtocol {
        return ImageNetworkService()
    }
    
    func locationEntitiesService() -> LocationEntitiesServiceProtocol {
        return LocationEntitiesNetworkService()
    }
    
    func photosService() -> PhotosServiceProtocol {
        return PhotosNetworkService()
    }
}
