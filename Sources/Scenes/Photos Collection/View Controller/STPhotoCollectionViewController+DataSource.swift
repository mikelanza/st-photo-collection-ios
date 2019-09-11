//
//  STPhotoCollectionViewController+DataSource.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension STPhotoCollectionViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.photoCollectionViewCellForIndexPath(indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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
    
    private func loadingFooterReusableView(kind: String, indexPath: IndexPath) -> STLoadingCollectionReusableView {
        return self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: STLoadingCollectionReusableView.defaultReuseIdentifier, for: indexPath) as? STLoadingCollectionReusableView ?? STLoadingCollectionReusableView(frame: .zero)
    }
    
    private func noPhotosCollectionFooterView(kind: String, indexPath: IndexPath) -> STNoPhotosCollectionFooterView {
        return self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: STNoPhotosCollectionFooterView.defaultReuseIdentifier, for: indexPath) as? STNoPhotosCollectionFooterView ?? STNoPhotosCollectionFooterView(frame: .zero)
    }
    
    private func noMorePhotosFooterView(kind: String, indexPath: IndexPath) -> STNoMorePhotosFooterView {
        return self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: STNoMorePhotosFooterView.defaultReuseIdentifier, for: indexPath) as? STNoMorePhotosFooterView ?? STNoMorePhotosFooterView(frame: .zero)
    }
    
    private func reusableCollectionFooterView(kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        return self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionReusableView", for: indexPath) ?? UICollectionReusableView()
    }
}

// MARK: - Photo collection view cell

extension STPhotoCollectionViewController: STPhotoCollectionViewCellDelegate {
    private func photoCollectionViewCellForIndexPath(indexPath: IndexPath) -> STPhotoCollectionViewCell {
        let cell = self.reusablePhotoCollectionViewCellForIndexPath(indexPath: indexPath)
        guard let displayedPhoto = self.sections[indexPath.section].items[indexPath.item] as? STPhotoCollection.DisplayedPhoto else { return cell }
        
        displayedPhoto.photoCollectionViewCellInterface = cell
        cell.delegate = self
        cell.photoId = displayedPhoto.id
        
        cell.setIsLoading(isLoading: displayedPhoto.isLoadingImage)
        cell.setImage(image: displayedPhoto.image)
        cell.setImageBackgroundColor(color: displayedPhoto.backgroundImageColor)
        
        self.shouldFetchImageForPhoto(displayedPhoto: displayedPhoto)
        return cell
    }
    
    private func reusablePhotoCollectionViewCellForIndexPath(indexPath: IndexPath) -> STPhotoCollectionViewCell {
        return self.collectionView?.dequeueReusableCell(withReuseIdentifier: STPhotoCollectionViewCell.defaultReuseIdentifier, for: indexPath) as? STPhotoCollectionViewCell ?? STPhotoCollectionViewCell()
    }
    
    func photoCollectionViewCell(cell: STPhotoCollectionViewCell?, didSelectContentView view: UIView?, photoId: String?) {
        let request = STPhotoCollection.PresentPhoto.Request(photoId: photoId)
        self.interactor?.shouldPresentPhoto(request: request)
    }
}

// MARK: - UICollectionViewDelegate

extension STPhotoCollectionViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let displayedPhoto = self.displayedPhotoFor(indexPath: indexPath)
        let request = STPhotoCollection.PresentPhoto.Request(photoId: displayedPhoto?.id)
        self.interactor?.shouldPresentPhoto(request: request)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension STPhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        var height: CGFloat = 0
        if self.sections[section].isLoading { height = 50 }
        else if self.sections[section].noItems { height = 120 }
        else if self.sections[section].noMoreItems { height = 120 }
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return self.firstItemSize()
        }
        return self.itemSize()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing: CGFloat = 1.0
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
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

extension STPhotoCollectionViewController {
    func insertDisplayedPhotos(displayedPhotos: [STPhotoCollection.DisplayedPhoto]) {
        DispatchQueue.main.async {
            self.collectionView?.collectionViewLayout.invalidateLayout()
            self.collectionView?.performBatchUpdates({
                let index = self.sections[STPhotoCollection.SectionIndex.photos.rawValue].items.count
                let indexPaths = displayedPhotos.enumerated().map({ IndexPath(item: index + $0.offset, section: STPhotoCollection.SectionIndex.photos.rawValue) })
                self.sections[STPhotoCollection.SectionIndex.photos.rawValue].items.append(contentsOf: displayedPhotos)
                self.collectionView?.insertItems(at: indexPaths)
            }, completion: { (success) in
                self.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }
    }
    
    private func displayedPhotoFor(indexPath: IndexPath) -> STPhotoCollection.DisplayedPhoto? {
        return self.sections[indexPath.section].items[indexPath.item] as? STPhotoCollection.DisplayedPhoto
    }
}

