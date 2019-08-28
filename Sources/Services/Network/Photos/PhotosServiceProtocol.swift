//
//  PhotoCommentsServiceProtocol.swift
//  STPhotoDetails
//
//  Created by Dimitri Strauneanu on 04/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import Foundation
import STPhotoCore

protocol PhotosServiceProtocol {
    func fetchPhotos(photoIds: [String]?, entityFilter: GetPhotosOperationModel.EntityFilter?, completionHandler: @escaping (Result<[STPhoto], OperationError>) -> Void)
}
