//
//  STPhotoCollectionInteractor+FetchImage.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 13/09/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import UIKit
import STPhotoCore

extension STPhotoCollectionInteractor {
    func shouldFetchImageForPhoto(request: STPhotoCollection.FetchImage.Request) {
        let image = request.displayedPhoto.image
        let imageUrl = request.displayedPhoto.imageUrl
        let isLoadingImage = request.displayedPhoto.isLoadingImage
        
        guard isLoadingImage == false else { return }
        
        if image == nil && imageUrl != nil {
            self.presenter?.presentWillFetchImage(response: STPhotoCollection.FetchImage.Response(displayedPhoto: request.displayedPhoto, image: nil))
            self.worker?.fetchImageFor(displayedPhoto: request.displayedPhoto)
        } else if image == nil && imageUrl == nil {
            self.presenter?.presentImage(response: STPhotoCollection.FetchImage.Response(displayedPhoto: request.displayedPhoto, image: UIImage()))
        }
    }
    
    func successDidFetchPhotoImage(displayedPhoto: STPhotoCollection.DisplayedPhoto, image: UIImage?) {
        self.presenter?.presentDidFetchImage(response: STPhotoCollection.FetchImage.Response(displayedPhoto: displayedPhoto, image: nil))
        self.presenter?.presentImage(response: STPhotoCollection.FetchImage.Response(displayedPhoto: displayedPhoto, image: image))
    }
    
    func failureDidFetchPhotoImage(displayedPhoto: STPhotoCollection.DisplayedPhoto, error: OperationError) {
        self.presenter?.presentDidFetchImage(response: STPhotoCollection.FetchImage.Response(displayedPhoto: displayedPhoto, image: nil))
        self.presenter?.presentImage(response: STPhotoCollection.FetchImage.Response(displayedPhoto: displayedPhoto, image: UIImage()))
    }
}


