//
//  NSHTTPURLResponse+QiitaApiClient.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

extension HTTPURLResponse {
    enum StatusCodeType: Int {
        case unknown = 0
        case ok = 200
        case created = 201
        case noContent = 204
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case internalServerError = 500
    }
    
    var statusCodeType: StatusCodeType {
        return StatusCodeType(rawValue: statusCode) ?? .unknown
    }
    
    public var totalCount: Int? {
        return Int(allHeaderFields["Total-Count"] as? String ?? "")
    }
}
