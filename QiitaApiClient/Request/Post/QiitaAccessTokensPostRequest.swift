//
//  QiitaAccessTokensPostRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaAccessTokensPostRequest: QiitaPostRequestable {
    
    public typealias ResultType = QiitaAccessToken
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public let path: String = "/access_tokens"
    public var parameters: [String : Any] {
        return [
            "client_id": clientId,
            "client_secret": clientSecret,
            "code": code
        ]
    }
    
    let clientId: String
    let clientSecret: String
    let code: String
    
    public init(clientId: String, clientSecret: String, code: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.code = code
    }
    
    public func validate() throws {}
}
