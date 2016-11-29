//
//  QiitaTagsFollowingDeleteRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaTagsFollowingDeleteRequest: QiitaDeleteRequestable {
    
    public typealias ResultType = Void
    public typealias DecodedJsonType = Void
    
    public var path: String {
        return "/tags/\(tagId)/following"
    }
    public let parameters: [String : Any] = [:]
    
    let tagId: Int
    
    public init(tagId: Int) {
        self.tagId = tagId
    }
    
    public func validate() throws {}
    
    public static func decode(data: Data) throws -> ResultType {}
}
