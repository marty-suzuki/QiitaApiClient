//
//  NSHTTPURLResponse+QiitaApiClient.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

extension NSHTTPURLResponse {
    enum StatusCodeType: Int {
        case Unknown = 0
        case OK = 200
        case Created = 201
        case NoContent = 204
        case BadRequest = 400
        case Unauthorized = 401
        case Forbidden = 403
        case NotFound = 404
        case InternalServerError = 500
    }
    
    var statusCodeType: StatusCodeType {
        return StatusCodeType(rawValue: statusCode) ?? .Unknown
    }
    
    public var totalCount: Int? {
        return Int(allHeaderFields["Total-Count"] as? String ?? "")
    }
}