//
//  QiitaItemsDeleteRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaItemsDeleteRequest: QiitaDeleteRequestable {
    
    public typealias ResultType = QiitaItem
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public var path: String {
        return "/items/" + itemId
    }
    public let parameters: [String : Any] = [:]
    
    let itemId: String
    
    public init(itemId: String) {
        self.itemId = itemId
    }
    
    public func validate() throws {}
}
