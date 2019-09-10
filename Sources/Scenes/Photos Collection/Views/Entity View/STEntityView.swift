//
//  STEntityView.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 08/08/2017.
//  Copyright © 2017 Streetography. All rights reserved.
//

import UIKit


class STEntityView: UIView {
    var model: STEntityViewModel {
        didSet {
            self.updateIsLoading()
            self.updateImage()
            self.updateTitle()
        }
    }
    
    private weak var imageView: UIImageView!
    private weak var titleLabel: UILabel!
    private weak var activityIndicatorView: UIActivityIndicatorView!
    
    init(viewModel: STEntityViewModel) {
        self.model = viewModel
        super.init(frame: .zero)
        self.setupSubviews()
        self.setupSubviewsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Update subviews

extension STEntityView {
    private func updateTitle() {
        DispatchQueue.main.async {
            self.titleLabel?.text = self.model.title
        }
    }
    
    private func updateImage() {
        DispatchQueue.main.async {
            if let imageName = self.model.imageName {
                self.imageView?.image = UIImage(named: imageName, in: Bundle.module, compatibleWith: nil)
            }
        }
    }
    
    private func updateIsLoading() {
        DispatchQueue.main.async {
            if self.model.isLoading {
                self.hideTitleLabel()
                self.startActivityIndicatorView()
                self.showActivityIndicatorView()
            } else {
                self.hideActivityIndicatorView()
                self.stopActivityIndicatorView()
                self.showTitleLabel()
            }
        }
    }
}

// MARK: - Subviews manipulation

extension STEntityView {
    private func startActivityIndicatorView() {
        self.activityIndicatorView?.startAnimating()
    }
    
    private func stopActivityIndicatorView() {
        self.activityIndicatorView?.stopAnimating()
    }
    
    private func showActivityIndicatorView() {
        self.activityIndicatorView?.isHidden = false
    }
    
    private func hideActivityIndicatorView() {
        self.activityIndicatorView?.isHidden = true
    }
    
    private func showTitleLabel() {
        self.titleLabel?.isHidden = false
    }
    
    private func hideTitleLabel() {
        self.titleLabel?.isHidden = true
    }
}

// MARK: - Subviews configuration

extension STEntityView {
    private func setupSubviews() {
        self.setupImageView()
        self.setupTitleLabel()
        self.setupActivityIndicatorView()
    }
    
    private func setupImageView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageName = self.model.imageName {
            imageView.image = UIImage(named: imageName)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.setContentHuggingPriority(UILayoutPriority.init(251), for: .horizontal)
        imageView.setContentHuggingPriority(UILayoutPriority.init(255), for: .vertical)
        imageView.setContentCompressionResistancePriority(UILayoutPriority.init(750), for: .horizontal)
        imageView.setContentCompressionResistancePriority(UILayoutPriority.init(755), for: .vertical)
        self.addSubview(imageView)
        self.imageView = imageView
    }
    
    private func setupTitleLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.white
        label.text = self.model.title
        label.setContentHuggingPriority(UILayoutPriority.init(245), for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority.init(251), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority.init(745), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority.init(750), for: .vertical)
        self.addSubview(label)
        self.titleLabel = label
    }
    
    private func setupActivityIndicatorView() {
        let activityIndicatorView = UIActivityIndicatorView(style: .white)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = false
        self.addSubview(activityIndicatorView)
        self.activityIndicatorView = activityIndicatorView
    }
}

// MARK: - Subviews constraints configuration

extension STEntityView {
    private func setupSubviewsConstraints() {
        self.setupImageViewConstraints()
        self.setupTitleLabelConstraints()
        self.setupActivityIndicatorViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        self.imageView?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.imageView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.imageView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupTitleLabelConstraints() {
        self.titleLabel?.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10).isActive = true
        self.titleLabel?.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.titleLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.titleLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.titleLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setupActivityIndicatorViewConstraints() {
        self.activityIndicatorView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.activityIndicatorView?.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10).isActive = true
    }
}
