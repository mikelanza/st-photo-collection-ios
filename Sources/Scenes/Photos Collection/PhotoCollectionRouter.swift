//
//  PhotoCollectionRouter.swift
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

protocol PhotoCollectionRoutingLogic: NSObjectProtocol {
    func removeViewController()
}

protocol PhotoCollectionDataPassing {
    var dataStore: PhotoCollectionDataStore? { get }
}

class PhotoCollectionRouter: NSObject, PhotoCollectionRoutingLogic, PhotoCollectionDataPassing {
    weak var viewController: PhotoCollectionViewController?
    var dataStore: PhotoCollectionDataStore?
    
    func removeViewController() {
        if let navigationController = self.viewController?.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.viewController?.dismiss(animated: true, completion: nil)
        }
    }
}