//
//  PhotosCollectionViewController+DataSource.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension PhotosCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.photoCollectionViewCellForIndexPath(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter: return self.footerViewForIndexPath(indexPath: indexPath)
        default: return self.reusableCollectionFooterView(kind: kind, indexPath: indexPath)
        }
    }
    
    private func footerViewForIndexPath(indexPath: IndexPath) -> UICollectionReusableView {
        if self.sections[indexPath.section].isLoading {
            return self.loadingFooterReusableView(kind: UICollectionView.elementKindSectionFooter, indexPath: indexPath)
        } else if self.sections[indexPath.section].noItems {
            return self.noPhotosCollectionFooterView(kind: UICollectionView.elementKindSectionFooter, indexPath: indexPath)
        } else if self.sections[indexPath.section].noMoreItems {
            return self.noMorePhotosFooterView(kind: UICollectionView.elementKindSectionFooter, indexPath: indexPath)
        } else {
            return self.reusableCollectionFooterView(kind: UICollectionView.elementKindSectionFooter, indexPath: indexPath)
        }
    }
    
    private func loadingFooterReusableView(kind: String, indexPath: IndexPath) -> LoadingCollectionReusableView {
        return self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingCollectionReusableView.defaultReuseIdentifier, for: indexPath) as? LoadingCollectionReusableView ?? LoadingCollectionReusableView(frame: .zero)
    }
    
    private func noPhotosCollectionFooterView(kind: String, indexPath: IndexPath) -> NoPhotosCollectionFooterView {
        return self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NoPhotosCollectionFooterView.defaultReuseIdentifier, for: indexPath) as? NoPhotosCollectionFooterView ?? NoPhotosCollectionFooterView(frame: .zero)
    }
    
    private func noMorePhotosFooterView(kind: String, indexPath: IndexPath) -> NoMorePhotosFooterView {
        return self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NoMorePhotosFooterView.defaultReuseIdentifier, for: indexPath) as? NoMorePhotosFooterView ?? NoMorePhotosFooterView(frame: .zero)
    }
    
    private func reusableCollectionFooterView(kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        return self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionReusableView", for: indexPath) ?? UICollectionReusableView()
    }
}

// MARK: - Photo collection view cell

extension PhotosCollectionViewController: PhotoCollectionViewCellDelegate {
    private func photoCollectionViewCellForIndexPath(indexPath: IndexPath) -> PhotoCollectionViewCell {
        let cell = self.reusablePhotoCollectionViewCellForIndexPath(indexPath: indexPath)
        let displayedPhoto = self.sections[indexPath.section].items[indexPath.item] as? PhotosCollection.DisplayedPhoto
        cell.photoId = displayedPhoto?.id
        cell.delegate = self
        cell.setImage(image: nil)
        displayedPhoto?.interface = cell
        self.shouldDownloadPhoto(displayedPhoto: displayedPhoto)
        
        cell.setImageBackgroundColor(color: displayedPhoto?.backgroundImageColor)
        return cell
    }
    
    private func reusablePhotoCollectionViewCellForIndexPath(indexPath: IndexPath) -> PhotoCollectionViewCell {
        return self.collectionView?.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.defaultReuseIdentifier, for: indexPath) as? PhotoCollectionViewCell ?? PhotoCollectionViewCell()
    }
    
    func photoCollectionViewCell(cell: PhotoCollectionViewCell?, didSelectContentView view: UIView?, photoId: String?) {
        let request = PhotosCollection.PresentPhoto.Request(photoId: photoId)
        self.interactor?.shouldPresentPhoto(request: request)
    }
}

// MARK: - UICollectionViewDelegate

extension PhotosCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let displayedPhoto = self.displayedPhotoFor(indexPath: indexPath)
        let request = PhotosCollection.PresentPhoto.Request(photoId: displayedPhoto?.id)
        self.interactor?.shouldPresentPhoto(request: request)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        var height: CGFloat = 0
        if self.sections[section].isLoading { height = 50 }
        else if self.sections[section].noItems { height = 120 }
        else if self.sections[section].noMoreItems { height = 120 }
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return self.firstItemSize()
        }
        return self.itemSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing: CGFloat = 1.0
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    private func firstItemSize() -> CGSize {
        let viewWidth = self.view.bounds.size.width
        let edgeInset: CGFloat = 1.0
        let itemWidth = viewWidth - (edgeInset * 2)
        let ratio: CGFloat = 0.47826087
        return CGSize(width: itemWidth, height: itemWidth * ratio)
    }
    
    private func itemSize() -> CGSize {
        switch UIApplication.shared.statusBarOrientation {
        case .portrait: return self.portraitItemSize()
        case .portraitUpsideDown: return self.portraitItemSize()
        case .landscapeLeft: return self.landscapeItemSize()
        case .landscapeRight: return self.landscapeItemSize()
        case .unknown: return self.portraitItemSize()
        @unknown default: return self.portraitItemSize()
        }
    }
    
    private func portraitItemSize() -> CGSize {
        let columns: CGFloat = 3
        return self.itemSizeForColumns(columns: columns)
    }
    
    private func landscapeItemSize() -> CGSize {
        let columns: CGFloat = 5
        return self.itemSizeForColumns(columns: columns)
    }
    
    private func itemSizeForColumns(columns: CGFloat) -> CGSize {
        var width: CGFloat
        if #available(iOS 11, *) {
            width = self.view.safeAreaLayoutGuide.layoutFrame.width
        } else {
            width = self.view.bounds.size.width
        }
        let spacing: CGFloat = 1.0
        let edgeInset: CGFloat = 1.0
        let itemWidth = floor((width - (edgeInset * 2 + spacing * (columns - 1))) / columns)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

// MARK: - Auxiliary

extension PhotosCollectionViewController {
    func insertDisplayedPhotos(displayedPhotos: [PhotosCollection.DisplayedPhoto]) {
        DispatchQueue.main.async {
            self.collectionView?.collectionViewLayout.invalidateLayout()
            self.collectionView?.performBatchUpdates({
                let index = self.sections[self.photosSectionIndex].items.count
                let indexPaths = displayedPhotos.enumerated().map({ IndexPath(item: index + $0.offset, section: self.photosSectionIndex) })
                self.sections[self.photosSectionIndex].items.append(contentsOf: displayedPhotos)
                self.collectionView?.insertItems(at: indexPaths)
            }, completion: { (success) in
                self.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }
    }
    
    func reloadPhotosSection() {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.collectionView?.reloadSections(IndexSet(integer: self.photosSectionIndex))
            }
        }
    }
    
    func invalidateCollectionViewLayout() {
        DispatchQueue.main.async {
            self.collectionView?.collectionViewLayout.invalidateLayout()
        }
    }
    
    private func reloadDisplayedPhoto(item: Int) {
        let indexPath = IndexPath(item: item, section: self.photosSectionIndex)
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.collectionView?.reloadItems(at: [indexPath])
            }
        }
    }
        
    func deletePhoto(photoId: String) {
        DispatchQueue.main.async {
            self.collectionView?.performBatchUpdates({
                if let index = self.index(photoId: photoId) {
                    let indexPath = IndexPath(item: index, section: self.photosSectionIndex)
                    self.sections[self.photosSectionIndex].items.remove(at: index)
                    self.collectionView?.deleteItems(at: [indexPath])
                }
            }, completion: nil)
        }
    }
    
    private func index(photoId: String) -> Int? {
        return self.sections[self.photosSectionIndex].items
            .enumerated()
            .reversed()
            .first(where: { ($0.element as? PhotosCollection.DisplayedPhoto)?.id == photoId })?.offset
    }
    
    private func displayedPhotoFor(indexPath: IndexPath) -> PhotosCollection.DisplayedPhoto? {
        return self.sections[indexPath.section].items[indexPath.item] as? PhotosCollection.DisplayedPhoto
    }
}

