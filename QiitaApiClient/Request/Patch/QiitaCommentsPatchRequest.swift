//
//  QiitaCommentsPatchRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaCommentsPatchRequest: QiitaPatchRequestable {
    
    public typealias ResultType = QiitaTemplate
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public var path: String {
        return "/comments/\(commentId)"
    }
    public var parameters: [String : Any] {
        return [
            "body": body
        ]
    }
    
    let commentId: String
    let body: String
    
    public init(commentId: String, body: String) {
        self.commentId = commentId
        self.body = body
    }
    
    public func validate() throws {}
}
