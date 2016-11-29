//
//  QiitaItemsPatchRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaItemsPatchRequest: QiitaPatchRequestable {
    
    public typealias ResultType = QiitaItem
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public var path: String {
        return "/items/" + itemId
    }
    public var parameters: [String : Any] {
        let tags: [[AnyHashable : Any]] = self.tags.flatMap { $0.dictionaryRepresentation() }
        return [
            "body" : body,
            "coediting" : coediting,
            "private" : `private`,
            "tags" : tags,
            "title" : title
        ]
    }
    
    let itemId: String
    let body: String
    let coediting: Bool
    let`private`: Bool
    let tags: [QiitaTagging]
    let title: String
    
    public init(itemId: String, body: String, coediting: Bool, `private`: Bool, tags: [QiitaTagging], title: String) {
        self.itemId = itemId
        self.body = body
        self.coediting = coediting
        self.`private` = `private`
        self.tags = tags
        self.title = title
    }
    
    public func validate() throws {}
}
