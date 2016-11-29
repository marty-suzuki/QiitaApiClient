//
//  QiitaProjectsDeleteRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaProjectsDeleteRequest: QiitaDeleteRequestable {
    
    public typealias ResultType = Void
    public typealias DecodedJsonType = Void
    
    public var path: String {
        return "/projects/\(progectId)"
    }
    public let parameters: [String : Any] = [:]
    
    let progectId: Int
    
    public init(progectId: Int) {
        self.progectId = progectId
    }
    
    public func validate() throws {}
    
    public static func decode(data: Data) throws -> ResultType {}
}
