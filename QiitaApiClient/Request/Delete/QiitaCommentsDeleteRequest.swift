//
//  QiitaCommentsDeleteRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaCommentsDeleteRequest: QiitaDeleteRequestable {
    
    public typealias ResultType = Void
    public typealias DecodedJsonType = Void
    
    public var path: String {
        return "/comments/\(commentId)"
    }
    public let parameters: [String : Any] = [:]
    
    let commentId: String
    
    public init(commentId: String) {
        self.commentId = commentId
    }
    
    public func validate() throws {}
}
