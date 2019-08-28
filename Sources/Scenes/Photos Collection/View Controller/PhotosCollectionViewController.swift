//
//  PhotosCollectionViewController.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 08/08/2017.
//  Copyright (c) 2017 Streetography. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import STPhotoCore

public protocol PhotoCollectionViewControllerDelegate: NSObjectProtocol {
    func photoCollectionViewController(_ viewController: PhotosCollectionViewController?, navigateToPhotoDetailsFor photoId: String?)
}

public class PhotosCollectionViewController: UIViewController {
    var interactor: PhotosCollectionBusinessLogic?
    var router: (NSObjectProtocol & PhotosCollectionRoutingLogic & PhotosCollectionDataPassing)?
    
    public weak var delegate: PhotoCollectionViewControllerDelegate?
    
    weak var entityView: EntityView!
    weak var collectionView: UICollectionView!
    
    struct Section {
        var title: String?
        var items: [Any]
        var isLoading: Bool = false
        var noMoreItems: Bool = false
        var noItems: Bool = false
        
        init(title: String?, items: [Any]) {
            self.title = title
            self.items = items
        }
    }
    
    var sections: [Section] = []
    var photosSectionIndex: Int = 0
    
    private lazy var photoItemSize: CGSize = {
        let spacing: CGFloat = 1.0
        let edgeInsets: CGFloat = 2.0
        let width = UIScreen.main.bounds.size.width
        let side = floor((width - (edgeInsets + spacing)) / 3)
        let scale = UIScreen.main.scale
        return CGSize(width: side * scale, height: side * scale)
    }()
    
    // MARK: Object lifecycle
    
    public init(model: PhotosCollection.Model) {
        super.init(nibName: nil, bundle: nil)
        self.setup()
        self.interactor?.setModel(model: model)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = PhotosCollectionInteractor()
        let presenter = PhotosCollectionPresenter()
        let router = PhotosCollectionRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.displayer = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupInteractor()
        self.setupSections()
        
        self.setupView()
        self.setupSubviews()
        self.setupSubviewsConstraints()

        self.shouldFetchEntityDetails()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar()
    }
    
    private func setupSections() {
        let photosSection = Section(title: nil, items: [])
        self.sections = [photosSection]
    }
    
    private func setupInteractor() {
        self.interactor?.setPhotoItemSize(size: self.photoItemSize)
    }
}

// MARK: - Business logic (VIP)

extension PhotosCollectionViewController {
    private func shouldFetchEntityDetails() {
        self.interactor?.shouldFetchEntityDetails()
    }
    
    func shouldDownloadPhoto(displayedPhoto: PhotosCollection.DisplayedPhoto?) {
        let request = PhotosCollection.DownloadPhoto.Request(displayedPhoto: displayedPhoto)
        self.interactor?.shouldDownloadPhoto(request: request)
    }
}

// MARK: - Scroll view delegate

extension PhotosCollectionViewController {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y.rounded(.up)
        let maximumOffset = (scrollView.contentSize.height - scrollView.frame.size.height).rounded(.up)
        if currentOffset == maximumOffset && scrollView.isDecelerating {
            self.interactor?.shouldFetchNextEntityPhotos()
        }
    }
}

// MARK: - Update & manipulate subviews

extension PhotosCollectionViewController {
    private func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - Actions

extension PhotosCollectionViewController {
    @objc func didTapBackButton() {
        self.router?.removeViewController()
    }
}
