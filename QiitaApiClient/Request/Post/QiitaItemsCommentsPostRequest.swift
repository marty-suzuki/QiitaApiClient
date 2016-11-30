//
//  QiitaItemsCommentsPostRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaItemsCommentsPostRequest: QiitaPostRequestable {
    
    public typealias ResultType = QiitaAccessToken
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public var path: String {
        return "/items/\(itemId)/comments"
    }
    public var parameters: [String : Any] {
        return [
            "body" : body
        ]
    }
    
    let itemId: String
    let body: String
    
    public init(itemId: String, body: String) {
        self.itemId = itemId
        self.body = body
    }
    
    public func validate() throws {}
}
