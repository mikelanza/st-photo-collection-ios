//
//  PhotoCollectionViewCell.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 08/08/2017.
//  Copyright © 2017 Streetography. All rights reserved.
//

import UIKit
import STPhotoCore

protocol PhotoCollectionViewCellDelegate: NSObjectProtocol {
    func photoCollectionViewCell(cell: PhotoCollectionViewCell?, didSelectContentView view: UIView?, photoId: String?)
}

class PhotoCollectionViewCell: UICollectionViewCell, DefaultReuseIdentifier, PhotoCollectionInterface {
    private weak var imageView: UIImageView!
    
    weak var delegate: PhotoCollectionViewCellDelegate?
    
    var photoId: String?
    
    init() {
        super.init(frame: .zero)
        self.setupContentViewTapGestureRecognizer()
        self.setupSubviews()
        self.setupSubviewsConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContentViewTapGestureRecognizer()
        self.setupSubviews()
        self.setupSubviewsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentViewTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PhotoCollectionViewCell.didTapContentView))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.contentView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapContentView() {
        self.delegate?.photoCollectionViewCell(cell: self, didSelectContentView: self.contentView, photoId: self.photoId)
    }
    
    func setImage(image: UIImage?) {
        DispatchQueue.main.async {
            self.imageView?.image = image
        }
    }
    
    func setImageBackgroundColor(color: UIColor?) {
        self.imageView?.backgroundColor = color ?? UIColor(red: 54/255, green: 62/255, blue: 75/255, alpha: 1)
    }
}

// MARK: - Setup subviews

extension PhotoCollectionViewCell {
    private func setupSubviews() {
        self.setupImageView()
    }
    
    private func setupSubviewsConstraints() {
        self.setupImageViewConstraints()
    }
    
    private func setupImageView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
        self.imageView = imageView
    }
    
    private func setupImageViewConstraints() {
        self.imageView?.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.imageView?.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.imageView?.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.imageView?.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}
