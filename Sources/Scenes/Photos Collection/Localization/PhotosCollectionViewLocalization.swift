//
//  PhotosCollectionViewLocalization.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 09/08/2017.
//  Copyright © 2017 Streetography. All rights reserved.
//

import Foundation

class PhotosCollectionViewLocalization {
    static let sharedInstance = PhotosCollectionViewLocalization()
    
    private init() {
    }
    
    private struct LocalizedKey {
        static let
        addToFavoritesButtonTitle = "AddToFavoritesButton.title",
        removeFromFavoritesButtonTitle = "RemoveFromFavoritesButton.title",
        noPhotosTitle = "NoPhotos.title",
        noMorePhotosTitle = "NoMorePhotos.title",
        blockedUserTitle = "BlockedUser.title"
    }

    let addToFavoritesButtonTitle = LocalizedKey.addToFavoritesButtonTitle.localized(in: Bundle.module)
    let removeFromFavoritesButtonTitle = LocalizedKey.removeFromFavoritesButtonTitle.localized(in: Bundle.module)
    
    let noPhotosTitle = LocalizedKey.noPhotosTitle.localized(in: Bundle.module)
    let noMorePhotosTitle = LocalizedKey.noMorePhotosTitle.localized(in: Bundle.module)

    let blockedUserTitle = LocalizedKey.blockedUserTitle.localized(in: Bundle.module)
}
