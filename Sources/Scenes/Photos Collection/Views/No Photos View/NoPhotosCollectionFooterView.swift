//
//  NoPhotosCollectionFooterView.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 10/09/2018.
//  Copyright © 2018 Streetography. All rights reserved.
//

import UIKit
import STPhotoCore

class NoPhotosCollectionFooterView: UICollectionReusableView, DefaultReuseIdentifier {
    private weak var imageView: UIImageView!
    private weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        self.setupSubviewsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleLabel(text: String) {
        self.titleLabel?.text = text
    }
}

// MARK: - Setup subviews

extension NoPhotosCollectionFooterView {
    private func setupSubviews() {
        self.setupImageView()
        self.setupTitleLabel()
    }
    
    private func setupSubviewsConstraints() {
        self.setupImageViewConstraints()
        self.setupTitleLabelConstraints()
    }
    
    private func setupImageView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "no_more_photos_icon")
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        self.imageView = imageView
    }
    
    private func setupImageViewConstraints() {
        self.imageView?.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.imageView?.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.imageView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.imageView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor(red: 185/255, green: 190/255, blue: 204/255, alpha: 1.0)
        label.text = PhotosCollectionViewLocalization.sharedInstance.noPhotosTitle
        self.addSubview(label)
        self.titleLabel = label
    }
    
    private func setupTitleLabelConstraints() {
        self.titleLabel?.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10).isActive = true
        self.titleLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
