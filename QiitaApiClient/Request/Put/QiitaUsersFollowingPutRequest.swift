//
//  QiitaUsersFollowingPutRequest.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/11/29.
//
//

import Foundation

public struct QiitaUsersFollowingPutRequest: QiitaPutRequestable {
    
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
