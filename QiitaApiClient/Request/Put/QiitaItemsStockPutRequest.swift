//
//  QiitaItemsStockPutRequest.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/11/29.
//
//

import Foundation

public struct QiitaItemsStockPutRequest: QiitaPutRequestable {
    
    public typealias ResultType = Void
    public typealias DecodedJsonType = Void
    
    public var path: String {
        return "/items/\(itemId)/stock"
    }
    public let parameters: [String : Any] = [:]
    
    let itemId: String
    
    public init(itemId: String) {
        self.itemId = itemId
    }
    
    public func validate() throws {}
    
    public static func decode(data: Data) throws -> ResultType {}
}
