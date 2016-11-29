//
//  QiitaProjectsPatchRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaProjectsPatchRequest: QiitaPatchRequestable {
    
    public typealias ResultType = QiitaProject
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public var path: String {
        return "/projects/\(progectId)"
    }
    public var parameters: [String : Any] {
        let tags: [[AnyHashable : Any]] = self.tags.flatMap { $0.dictionaryRepresentation() }
        return [
            "archived" : archived,
            "body" : body,
            "name" : name,
            "tags" : tags
        ]
    }
    
    let progectId: Int
    let archived: Bool
    let body: String
    let name: String
    let tags: [QiitaTagging]
    
    public init(progectId: Int, archived: Bool, body: String, name: String, tags: [QiitaTagging]) {
        self.progectId = progectId
        self.archived = archived
        self.body = body
        self.name = name
        self.tags = tags
    }
    
    public func validate() throws {}
}
