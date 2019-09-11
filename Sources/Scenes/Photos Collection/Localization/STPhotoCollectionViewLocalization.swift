//
//  STPhotoCollectionViewLocalization.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 09/08/2017.
//  Copyright © 2017 Streetography. All rights reserved.
//

import Foundation

class STPhotoCollectionViewLocalization {
    static let sharedInstance = STPhotoCollectionViewLocalization()
    
    private init() {
    }
    
    private struct LocalizedKey {
        static let
        noPhotosTitle = "NoPhotos.title",
        noMorePhotosTitle = "NoMorePhotos.title"
    }
    
    let noPhotosTitle = LocalizedKey.noPhotosTitle.localized(in: Bundle.module)
    let noMorePhotosTitle = LocalizedKey.noMorePhotosTitle.localized(in: Bundle.module)
}
