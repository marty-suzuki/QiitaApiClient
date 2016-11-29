//
//  QiitaAccessTokensDeleteRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaAccessTokensDeleteRequest: QiitaDeleteRequestable {
    
    public typealias ResultType = Void
    public typealias DecodedJsonType = Void
    
    public var path: String {
        return "/access_tokens/" + accessToken
    }
    public let parameters: [String : Any] = [:]
    
    let accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    public func validate() throws {}
    
    public static func decode(data: Data) throws -> ResultType {}
}
