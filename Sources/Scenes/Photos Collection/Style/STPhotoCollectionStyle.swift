//
//  STPhotoCollectionStyle.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 23/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import UIKit
import STPhotoCore

class STPhotoCollectionStyle {
    static let shared = STPhotoCollectionStyle()
    
    var contentViewModel: ContentViewModel
    var entityViewModel: EntityViewModel
    var navigationBarModel: NavigationBarModel
    var backButtonModel: BackButtonModel
    var noPhotosModel: NoPhotosModel
    var noMorePhotosModel: NoMorePhotosModel
    var collectionViewModel: CollectionViewModel

    private init() {
        self.contentViewModel = ContentViewModel()
        self.entityViewModel = EntityViewModel()
        self.navigationBarModel = NavigationBarModel()
        self.backButtonModel = BackButtonModel()
        self.noPhotosModel = NoPhotosModel()
        self.noMorePhotosModel = NoMorePhotosModel()
        self.collectionViewModel = CollectionViewModel()
    }
    
    struct ContentViewModel {
        var backgroundColor: UIColor = UIColor(red: 53/255, green: 61/255, blue: 75/255, alpha: 1)
    }
    
    struct NavigationBarModel {
        var isTranslucent: Bool = false
        var tintColor: UIColor = UIColor.white
        var barTintColor: UIColor = UIColor(red: 53/255, green: 61/255, blue: 75/255, alpha: 1)
        var barStyle: UIStatusBarStyle = .lightContent
        var backgroundImage: UIImage = UIImage()
        var shadowImage: UIImage = UIImage()
    }
    
    struct BackButtonModel {
        var image: UIImage = UIImage(named: "st_photo_collection_back_arrow", in: Bundle.module, compatibleWith: nil)!
    }
    
    struct EntityViewModel {
        var backgroundColor: UIColor = UIColor(red: 53/255, green: 61/255, blue: 75/255, alpha: 1)
    }
    
    struct NoPhotosModel {
        var titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 185/255, green: 190/255, blue: 204/255, alpha: 1.0),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)
        ]
        var image: UIImage = UIImage(named: "st_photo_collection_no_photos", in: Bundle.module, compatibleWith: nil)!
    }
    
    struct NoMorePhotosModel {
        var titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 185/255, green: 190/255, blue: 204/255, alpha: 1.0),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)
        ]
        var image: UIImage = UIImage(named: "st_photo_collection_no_more_photos", in: Bundle.module, compatibleWith: nil)!
    }
    
    struct CollectionViewModel {
        var backgroundColor: UIColor = UIColor.white
    }
}
