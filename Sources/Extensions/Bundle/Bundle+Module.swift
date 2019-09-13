//
//  Bundle+Module.swift
//  STPhotoCollection-iOS
//
//  Created by Crasneanu Cristian on 23/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import Foundation

import Foundation

extension Bundle {
    private class STPhotoCollectionModule { }
    
    static var module: Bundle {
        let bundle = Bundle(for: STPhotoCollectionModule.self)
        guard let url = bundle.url(forResource: "STPhotoCollection", withExtension: "bundle") else { return bundle }
        return Bundle(url: url) ?? bundle
    }
}
