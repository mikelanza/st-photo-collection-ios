//
//  GetPhotosOperationRequestBuilder.swift
//  STPhotoCollection-iOS
//
//  Created by Dimitri Strauneanu on 02/08/2019.
//  Copyright © 2019 Streetography. All rights reserved.
//

import Foundation
import STPhotoCore

class GetPhotosOperationRequestBuilder {
    private let model: GetPhotosOperationModel.Request
    
    init(model: GetPhotosOperationModel.Request) {
        self.model = model
    }
    
    public func request() -> URLRequest? {
        guard let baseUrl = URL(string: EndpointsBuilder.shared.getPhotosEndpoint()), let url = self.addQueryParameters(self.parameters(), toURL: baseUrl) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    private func addQueryParameters(_ queryParameters: [String : Any], toURL url: URL) -> URL? {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        let queryItems = queryParameters.map { (key, value) in
            return URLQueryItem(name: key, value: "\(value)")
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    private func parameters() -> [String : Any] {
        var parameters: [String: Any] = [:]
        parameters[Parameters.APIKey] = EndpointsBuilder.apiSecret
        
        var parseParameters: [String: Any] = [:]
        parseParameters[Parameters.Skip] = self.model.entityFilter?.skip
        parseParameters[Parameters.Limit] = self.model.entityFilter?.limit
        parseParameters[Parameters.IncludeKey] = Parameters.Owner
        parseParameters[Parameters.Order] = "-likes,-owner,-fhTimesViewed"
        
        if let photoIds = self.model.photoIds {
            parseParameters[Parameters.Where] = self.whereParametersForPhotoIds(photoIds: photoIds)
        } else if let entityFilter = self.model.entityFilter {
            parseParameters[Parameters.Where] = self.whereParametersForEntity(entityFilter: entityFilter)
        }
        
        do {
            let parseParametersData = try JSONSerialization.data(withJSONObject: parseParameters, options: JSONSerialization.WritingOptions(rawValue: UInt(0)))
            let parseParametersString = NSString(data: parseParametersData, encoding: String.Encoding.utf8.rawValue)
            parameters[Parameters.ParseQuery] = parseParametersString
            return parameters
        } catch {
            return parameters
        }
    }
    
    private func parametersFor(filter: GetPhotosOperationModel.Filter) -> [String : Any] {
        var parameters: [String : Any] = [:]
        
        parameters["isProfilePhoto"] = ["$ne" : true] as AnyObject
        
        if let userId = filter.userId {
            parameters["owner"] = ["__type" : "Pointer", "className" : "_User", "objectId" : userId] as AnyObject
        }
        
        if let collectionId = filter.collectionId {
            parameters["collectionID"] = collectionId as AnyObject
        }
        
        return parameters
    }
    
    private struct Parameters {
        static let
        APIKey = "apisecret",
        
        ObjectId = "objectId",
        
        Where = "where",
        ParseQuery = "parseQuery",
        IncludeKey = "includeKey",
        
        Limit = "limit",
        Skip = "skip",
        
        Owner = "owner",
        
        Order = "order"
    }
    
    private func whereParametersForEntity(entityFilter: GetPhotosOperationModel.EntityFilter) -> [String : Any] {
        var parameters: [String : Any] = [:]
        
        parameters["\(entityFilter.entity.entityType)ID"] = entityFilter.entity.entityId as AnyObject
        
        parameters["isProfilePhoto"] = ["$ne" : true] as AnyObject
        
        if let userId = entityFilter.filter.userId {
            parameters["owner"] = ["__type" : "Pointer", "className" : "_User", "objectId" : userId] as AnyObject
        }
        
        if let collectionId = entityFilter.filter.collectionId {
            parameters["collectionID"] = collectionId as AnyObject
        }
        
        return parameters
    }
    
    private func whereParametersForPhotoIds(photoIds: [String]) -> [String : Any] {
        return [Parameters.ObjectId : ["$in": photoIds] as AnyObject]
    }
}
