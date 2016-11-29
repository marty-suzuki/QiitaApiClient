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
    
    public static func decode(data: Data) throws -> ResultType {
        let decodedJson = try jsonDecode(data: data)
        guard let item = QiitaComment(dictionary: decodedJson) else {
            throw QiitaAPIClientError.decodeFailed(reason: "can not convert to QiitaComment")
        }
        return item
    }
}
