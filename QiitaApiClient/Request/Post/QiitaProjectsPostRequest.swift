//
//  QiitaProjectsPostRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaProjectsPostRequest: QiitaPostRequestable {
    
    public typealias ResultType = QiitaProject
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public let path: String = "/projects"
    public var parameters: [String : Any] {
        let tags: [[AnyHashable : Any]] = self.tags.flatMap { $0.dictionaryRepresentation() }
        return [
            "archived" : archived,
            "body" : body,
            "name" : name,
            "tags" : tags
        ]
    }
    
    let archived: Bool
    let body: String
    let name: String
    let tags: [QiitaTagging]
    
    public init(archived: Bool, body: String, name: String, tags: [QiitaTagging]) {
        self.archived = archived
        self.body = body
        self.name = name
        self.tags = tags
    }
    
    public func validate() throws {}
}
