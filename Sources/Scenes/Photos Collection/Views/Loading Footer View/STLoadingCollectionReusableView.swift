//
//  STLoadingCollectionReusableView.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 08/08/2017.
//  Copyright © 2017 Streetography. All rights reserved.
//

import UIKit
import STPhotoCore

class STLoadingCollectionReusableView: UICollectionReusableView, DefaultReuseIdentifier {
    
    private weak var activityIndicatorView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupActivityIndicatorView()
        self.setupActivityIndicatorViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActivityIndicatorView() {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = UIColor.darkGray
        view.startAnimating()
        view.isHidden = false
        self.addSubview(view)
        self.activityIndicatorView = view
    }
    
    private func setupActivityIndicatorViewConstraints() {
        self.activityIndicatorView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.activityIndicatorView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func hideActivityIndicator() {
        self.activityIndicatorView?.isHidden = true
    }
    
}
