//
//  QiitaTemplatesPatchRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaTemplatesPatchRequest: QiitaPatchRequestable {
    
    public typealias ResultType = QiitaTemplate
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public var path: String {
        return "/templates/\(templateId)"
    }
    public var parameters: [String : Any] {
        let tags: [[AnyHashable : Any]] = self.tags.flatMap { $0.dictionaryRepresentation() }
        return [
            "body" : body,
            "name" : name,
            "tags" : tags,
            "title" : title
        ]
    }
    
    let templateId: Int
    let body: String
    let name: String
    let tags: [QiitaTagging]
    let title: String
    
    public init(templateId: Int, body: String, name: String, tags: [QiitaTagging], title: String) {
        self.templateId = templateId
        self.body = body
        self.name = name
        self.tags = tags
        self.title = title
    }
    
    public func validate() throws {}
}
