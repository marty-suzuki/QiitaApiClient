//
//  QiitaItemsTaggingsPostRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaItemsTaggingsPostRequest: QiitaPostRequestable {
    
    public typealias ResultType = QiitaTagging
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public var path: String {
        return "/items/\(itemId)/taggings"
    }
    public var parameters: [String : Any] {
        return [
            "name" : name,
            "versions" : versions
        ]
    }
    
    let itemId: String
    let name: String
    let versions: [String]
    
    public init(itemId: String, name: String, versions: [String]) {
        self.itemId = itemId
        self.name = name
        self.versions = versions
    }
    
    public func validate() throws {}
}
