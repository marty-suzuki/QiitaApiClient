//
//  QiitaCommentsThankPutRequest.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/11/29.
//
//

import Foundation

public struct QiitaCommentsThankPutRequest: QiitaPutRequestable {
    
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
