//
//  STNoPhotosCollectionFooterView.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 10/09/2018.
//  Copyright © 2018 Streetography. All rights reserved.
//

import UIKit
import STPhotoCore

class STNoPhotosCollectionFooterView: UICollectionReusableView, DefaultReuseIdentifier {
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
    
    func setAttributedTitle(_ attributedTitle: NSAttributedString?) {
        self.titleLabel?.attributedText = attributedTitle
    }
}

// MARK: - Setup subviews

extension STNoPhotosCollectionFooterView {
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
        imageView.image = STPhotoCollectionStyle.shared.noPhotosModel.image
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
        label.attributedText = NSAttributedString(string: STPhotoCollectionViewLocalization.sharedInstance.noPhotosTitle, attributes: STPhotoCollectionStyle.shared.noPhotosModel.titleTextAttributes)
        self.addSubview(label)
        self.titleLabel = label
    }
    
    private func setupTitleLabelConstraints() {
        self.titleLabel?.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10).isActive = true
        self.titleLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
