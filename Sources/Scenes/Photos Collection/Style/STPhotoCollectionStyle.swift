//
//  PhotoCollectionStyle.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 23/08/2019.
//  Copyright © 2019 mikelanza. All rights reserved.
//

import UIKit

class STPhotoCollectionStyle {
    static let shared = STPhotoCollectionStyle()
    
    var entityViewModel: EntityViewModel

    private init() {
        self.entityViewModel = EntityViewModel()
    }
    
    struct EntityViewModel {
        var backgroundColor: UIColor = UIColor(red: 53/255, green: 61/255, blue: 75/255, alpha: 1)
    }
}
