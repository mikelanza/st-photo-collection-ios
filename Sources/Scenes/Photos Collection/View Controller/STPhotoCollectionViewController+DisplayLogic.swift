//
//  STPhotoCollectionViewController+DisplayLogic.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import Foundation

protocol STPhotoCollectionDisplayLogic: class {
    func displayFetchedPhotos(viewModel: STPhotoCollection.FetchPhotos.ViewModel)
    func displayEntityDetails(viewModel: STPhotoCollection.PresentEntityDetails.ViewModel)
    
    func displayWillFetchEntityDetails()
    func displayDidFetchEntityDetails()
    
    func displayWillFetchPhotos()
    func displayDidFetchPhotos()
    
    func displayNoPhotos()
    func displayNoMorePhotos()
    
    func displayPhotoDetailView(viewModel: STPhotoCollection.PresentPhotoDetail.ViewModel)
    
    func displayWillFetchImage(viewModel: STPhotoCollection.FetchImage.ViewModel)
    func displayDidFetchImage(viewModel: STPhotoCollection.FetchImage.ViewModel)
    func displayImage(viewModel: STPhotoCollection.FetchImage.ViewModel)
}

// MARK: - Display logic (VIP)

extension STPhotoCollectionViewController: STPhotoCollectionDisplayLogic {
    func displayEntityDetails(viewModel: STPhotoCollection.PresentEntityDetails.ViewModel) {
        let entityViewModel = STEntityViewModel(title: viewModel.title, imageName: viewModel.imageName)
        self.entityView?.model = entityViewModel
    }
    
    func displayFetchedPhotos(viewModel: STPhotoCollection.FetchPhotos.ViewModel) {
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
    
    func displayPhotoDetailView(viewModel: STPhotoCollection.PresentPhotoDetail.ViewModel) {
        self.delegate?.photoCollectionViewController(self, navigateToPhotoDetailsFor: viewModel.photo.id)
    }
    
    func displayWillFetchImage(viewModel: STPhotoCollection.FetchImage.ViewModel) {
        DispatchQueue.main.async {
            viewModel.displayedPhoto.isLoadingImage = true
            viewModel.displayedPhoto.photoCollectionViewCellInterface?.setIsLoading(isLoading: true)
        }
    }
    
    func displayDidFetchImage(viewModel: STPhotoCollection.FetchImage.ViewModel) {
        DispatchQueue.main.async {
            viewModel.displayedPhoto.isLoadingImage = false
            viewModel.displayedPhoto.photoCollectionViewCellInterface?.setIsLoading(isLoading: true)
        }
    }
    
    func displayImage(viewModel: STPhotoCollection.FetchImage.ViewModel) {
        DispatchQueue.main.async {
            viewModel.displayedPhoto.image = viewModel.image
            viewModel.displayedPhoto.photoCollectionViewCellInterface?.setImage(image: viewModel.image)
        }
    }
}
