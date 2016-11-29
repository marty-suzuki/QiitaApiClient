//
//  QiitaTemplatesDeleteRequest.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public struct QiitaTemplatesDeleteRequest: QiitaDeleteRequestable {
    
    public typealias ResultType = Void
    public typealias DecodedJsonType = Void
    
    public var path: String {
        return "/templates/\(templateId)"
    }
    public let parameters: [String : Any] = [:]
    
    let templateId: Int
    
    public init(templateId: Int) {
        self.templateId = templateId
    }
    
    public func validate() throws {}
    
    public static func decode(data: Data) throws -> ResultType {}
}
