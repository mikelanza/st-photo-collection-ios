//
//  PhotosCollectionViewController+DisplayLogic.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import Foundation

protocol PhotosCollectionDisplayLogic: class {
    func displayFetchedPhotos(viewModel: PhotosCollection.FetchPhotos.ViewModel)
    func displayEntityDetails(viewModel: PhotosCollection.PresentEntityDetails.ViewModel)
    
    func displayWillFetchEntityDetails()
    func displayDidFetchEntityDetails()
    
    func displayWillFetchPhotos()
    func displayDidFetchPhotos()
    
    func displayNoPhotos()
    func displayNoMorePhotos()
    
    func displayPhotoDetailView(viewModel: PhotosCollection.PresentPhotoDetail.ViewModel)
}

// MARK: - Display logic (VIP)

extension PhotosCollectionViewController: PhotosCollectionDisplayLogic {
    func displayEntityDetails(viewModel: PhotosCollection.PresentEntityDetails.ViewModel) {
        let entityViewModel = EntityViewModel(title: viewModel.title, imageName: viewModel.imageName)
        self.entityView?.model = entityViewModel
    }
    
    func displayFetchedPhotos(viewModel: PhotosCollection.FetchPhotos.ViewModel) {
        self.insertDisplayedPhotos(displayedPhotos: viewModel.displayedPhotos)
    }
    
    func displayWillFetchEntityDetails() {
        self.entityView?.model.isLoading = true
    }
    
    func displayDidFetchEntityDetails() {
        self.entityView?.model.isLoading = false
    }
    
    func displayWillFetchPhotos() {
        DispatchQueue.main.async {
            self.collectionView?.performBatchUpdates({
                self.sections[self.photosSectionIndex].isLoading = true
            }, completion: { completed in
                self.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }
    }
    
    func displayDidFetchPhotos() {
        DispatchQueue.main.async {
            self.collectionView?.performBatchUpdates({
                self.sections[self.photosSectionIndex].isLoading = false
            }, completion: { completed in
                self.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }
    }
    
    func displayNoPhotos() {
        DispatchQueue.main.async {
            self.collectionView?.performBatchUpdates({
                self.sections[self.photosSectionIndex].noItems = true
            }, completion: { completed in
                self.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }
    }
    
    func displayNoMorePhotos() {
        DispatchQueue.main.async {
            self.collectionView?.performBatchUpdates({
                self.sections[self.photosSectionIndex].noMoreItems = true
            }, completion: { completed in
               self.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }
    }
    
    func displayPhotoDetailView(viewModel: PhotosCollection.PresentPhotoDetail.ViewModel) {
        self.delegate?.photoCollectionViewController(self, navigateToPhotoDetailsFor: viewModel.photo.id)
    }
}
