//
//  QiitaUsersFollowingDeleteRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaUsersFollowingDeleteRequest: QiitaDeleteRequestable {
    
    public typealias ResultType = Void
    public typealias DecodedJsonType = Void
    
    public var path: String {
        return "/users/\(userId)/following"
    }
    public let parameters: [String : Any] = [:]
    
    let userId: String
    
    public init(userId: String) {
        self.userId = userId
    }
    
    public func validate() throws {}
}
