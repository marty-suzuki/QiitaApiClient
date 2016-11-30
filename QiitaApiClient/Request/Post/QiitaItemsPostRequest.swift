//
//  QiitaItemsPostRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaItemsPostRequest: QiitaPostRequestable {
    
    public typealias ResultType = QiitaItem
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public let path: String = "/items"
    public var parameters: [String : Any] {
        let tags: [[AnyHashable : Any]] = self.tags.flatMap { $0.dictionaryRepresentation() }
        return [
            "body" : body,
            "coediting" : coediting,
            "gist" : gist,
            "private" : `private`,
            "tags" : tags,
            "title" : title,
            "tweet" : tweet
        ]
    }
    
    let body: String
    let coediting: Bool
    let gist: Bool
    let `private`: Bool
    let tags: [QiitaTagging]
    let title: String
    let tweet: Bool
    
    public init(body: String, coediting: Bool, gist: Bool, `private`: Bool, tags: [QiitaTagging], title: String, tweet: Bool) {
        self.body = body
        self.coediting = coediting
        self.gist = gist
        self.`private` = `private`
        self.tags = tags
        self.title = title
        self.tweet = tweet
    }
    
    public func validate() throws {}
}
