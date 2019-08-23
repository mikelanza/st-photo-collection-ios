//
//  EntityViewModel.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 08/08/2017.
//  Copyright © 2017 Streetography. All rights reserved.
//

import Foundation

struct EntityViewModel {
    var title: String?
    var imageName: String?
    var isLoading: Bool = false
    
    init(title: String?, imageName: String?) {
        self.imageName = imageName
        self.title = title
    }
}
