//
//  PhotoCollectionViewController+Subviews.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 31/07/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import UIKit

// MARK: - Setup subviews

extension PhotoCollectionViewController {
    func setupSubviews() {
        self.setupNavigationBar()
        self.setupNavigationBarBackButton()
        self.setupEntityView()
        self.setupCollectionView()
    }
    
    func setupView() {
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.white
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = STPhotoCollectionStyle.shared.navigationBarModel.isTranslucent
        self.navigationController?.navigationBar.barTintColor = STPhotoCollectionStyle.shared.navigationBarModel.barTintColor
        self.navigationController?.navigationBar.tintColor = STPhotoCollectionStyle.shared.navigationBarModel.tintColor
        self.navigationController?.navigationBar.setBackgroundImage(STPhotoCollectionStyle.shared.navigationBarModel.backgroundImage, for: .default)
        self.navigationController?.navigationBar.shadowImage = STPhotoCollectionStyle.shared.navigationBarModel.shadowImage
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: STPhotoCollectionStyle.shared.navigationBarModel.tintColor]
    }
    
    private func setupNavigationBarBackButton() {
        let button = UIBarButtonItem(image: STPhotoCollectionStyle.shared.backButtonModel.image, style: .plain, target: self, action: #selector(PhotoCollectionViewController.didTapBackButton))
        self.navigationItem.leftBarButtonItem = button
    }
    
    private func setupActivityIndicatorNavigationBarButton() {
        let view = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 30, height: 30))
        view.startAnimating()
        let item = UIBarButtonItem(customView: view)
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItem = item
        }
    }
    
    private func setupEntityView() {
        let viewModel = EntityViewModel(title: nil, imageName: nil)
        let view = EntityView(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = STPhotoCollectionStyle.shared.entityViewModel.backgroundColor
        self.view.addSubview(view)
        self.entityView = view
    }
    
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.defaultReuseIdentifier)
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "UICollectionReusableView")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UICollectionReusableView")
        
        collectionView.register(LoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingCollectionReusableView.defaultReuseIdentifier)
        collectionView.register(NoPhotosCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NoPhotosCollectionFooterView.defaultReuseIdentifier)
        collectionView.register(NoMorePhotosFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NoMorePhotosFooterView.defaultReuseIdentifier)
        
        self.view.addSubview(collectionView)
        self.collectionView = collectionView
    }
}

// MARK: - Setup subviews constraints

extension PhotoCollectionViewController {
    func setupSubviewsConstraints() {
        self.setupEntityViewConstraints()
        self.setupCollectionViewConstraints()
    }
    
    private func setupEntityViewConstraints() {
        self.entityView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.entityView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.entityView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.entityView?.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupCollectionViewConstraints() {
        if #available(iOS 11, *) {
            self.collectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            self.collectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
        self.collectionView?.topAnchor.constraint(equalTo: self.entityView.bottomAnchor).isActive = true
        self.collectionView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.collectionView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
}