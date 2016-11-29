//
//  QiitaTagsFollowingPutRequest.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/11/29.
//
//

import Foundation

public struct QiitaTagsFollowingPutRequest: QiitaPutRequestable {
    
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
}
