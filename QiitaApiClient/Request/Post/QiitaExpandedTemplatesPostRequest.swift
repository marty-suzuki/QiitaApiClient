//
//  QiitaExpandedTemplatesPostRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaExpandedTemplatesPostRequest: QiitaPostRequestable {
    
    public typealias ResultType = QiitaExpandedTemplate
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public let path: String = "/expanded_templates"
    public var parameters: [String : Any] {
        let tags: [[AnyHashable : Any]] = self.tags.flatMap { $0.dictionaryRepresentation() }
        return [
            "body" : body,
            "tags" : tags,
            "title" : title
        ]
    }
    
    let body: String
    let tags: [QiitaTagging]
    let title: String
    
    public init(body: String, tags: [QiitaTagging], title: String) {
        self.body = body
        self.tags = tags
        self.title = title
    }
    
    public func validate() throws {}
}
