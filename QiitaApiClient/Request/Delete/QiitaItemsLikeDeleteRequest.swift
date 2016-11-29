//
//  QiitaItemsLikeDeleteRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaItemsLikeDeleteRequest: QiitaDeleteRequestable {
    
    public typealias ResultType = Void
    public typealias DecodedJsonType = Void
    
    public var path: String {
        return "/items/\(itemId)/like"
    }
    public let parameters: [String : Any] = [:]
    
    let itemId: String
    
    public init(itemId: String) {
        self.itemId = itemId
    }
    
    public func validate() throws {}
    
    public static func decode(data: Data) throws -> ResultType {}
}
