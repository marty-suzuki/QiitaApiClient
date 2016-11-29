//
//  QiitaItemsTaggingsDeleteRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaItemsTaggingsDeleteRequest: QiitaDeleteRequestable {
    
    public typealias ResultType = Void
    public typealias DecodedJsonType = Void
    
    public var path: String {
        return "/items/\(itemId)/taggings/\(taggingId)"
    }
    public let parameters: [String : Any] = [:]
    
    let itemId: String
    let taggingId: Int
    
    public init(itemId: String, taggingId: Int) {
        self.itemId = itemId
        self.taggingId = taggingId
    }
    
    public func validate() throws {}
}
