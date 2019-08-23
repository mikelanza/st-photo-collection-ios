//
//  PhotoCollectionStyle.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 23/08/2019.
//  Copyright © 2019 mikelanza. All rights reserved.
//

import UIKit
import STPhotoCore

class STPhotoCollectionStyle {
    static let shared = STPhotoCollectionStyle()
    
    var entityViewModel: EntityViewModel
    var navigationBarModel: NavigationBarModel
    var backButtonModel: BackButtonModel

    private init() {
        self.entityViewModel = EntityViewModel()
        self.navigationBarModel = NavigationBarModel()
        self.backButtonModel = BackButtonModel()
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
}
