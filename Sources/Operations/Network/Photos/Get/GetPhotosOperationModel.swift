//
//  GetPhotosOperationModel.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 02/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import Foundation
import STPhotoCore

enum GetPhotosOperationModel {
    struct Request {
        let photoIds: [String]?
        let entityFilter: EntityFilter?
    }
    
    struct Response: Codable {
        var photos: [STPhoto] = []
                
        init(photos: [STPhoto]) {
            self.photos = photos
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.photos = try container.decodeWrapper(key: .photos, defaultValue: [])
        }
    }
    
    struct EntityFilter {
        let limit: Int
        let skip: Int
        let entity: Entity
        let filter: Filter
    }
    
    struct Entity {
        let entityId: Int
        let entityType: String
    }
    
    struct Filter {
        let userId: String?
        let collectionId: String?
    }
}
