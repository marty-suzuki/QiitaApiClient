//
//  QiitaCommentsThankDeleteRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaCommentsThankDeleteRequest: QiitaDeleteRequestable {
    
    public typealias ResultType = QiitaComment
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public var path: String {
        return "/comments/\(commentId)/thank"
    }
    public let parameters: [String : Any] = [:]
    
    let commentId: String
    
    public init(commentId: String) {
        self.commentId = commentId
    }
    
    public func validate() throws {}
}
