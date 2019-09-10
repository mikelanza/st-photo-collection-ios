//
//  STPhotoCollectionViewCellInterfaceSpy.swift
//  STPhotoCollectionTests-iOS
//
//  Created by Crasneanu Cristian on 10/09/2019.
//  Copyright © 2019 mikelanza. All rights reserved.
//

@testable import STPhotoCollection
import UIKit

class STPhotoCollectionViewCellInterfaceSpy: NSObject, STPhotoCollectionViewCellInterface {
    var setImageCalled: Bool = false
    var setIsLoadingCalled: Bool = false
    
    func setImage(image: UIImage?) {
        self.setImageCalled = true
    }
    
    func setIsLoading(isLoading: Bool) {
        self.setIsLoadingCalled = true
    }
}
