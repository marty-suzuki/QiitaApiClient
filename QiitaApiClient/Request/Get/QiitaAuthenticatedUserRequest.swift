//
//  QiitaAuthenticatedUserRequest.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/11/28.
//
//

import Foundation

public struct QiitaAuthenticatedUserRequest: QiitaGetRequestable {
    
    public typealias ResultType = QiitaAuthenticatedUser
    public typealias DecodedJsonType = [AnyHashable : Any]
    
    public let path: String = "/authenticated_user"
    public let parameters: [String : Any] = [:]
    public let useAccessToken: Bool = true
    
    public init() {}
    
    public func validate() throws {}
}
