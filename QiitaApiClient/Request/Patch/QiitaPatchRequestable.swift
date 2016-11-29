//
//  QiitaPatchRequestable.swift
//  QiitaApiClient
//
//  Created by marty-suzuki on 2016/11/30.
//
//

import Foundation

public protocol QiitaPatchRequestable: QiitaRequestable {}

extension QiitaPatchRequestable {
    public var useAccessToken: Bool {
        return true
    }
    
    public var httpMethod: HttpMethod {
        return .patch
    }
}
