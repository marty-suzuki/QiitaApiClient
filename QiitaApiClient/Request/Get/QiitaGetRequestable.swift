//
//  QiitaGetRequestable.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/11/28.
//
//

import Foundation

public protocol QiitaGetRequestable: QiitaRequestable {}

extension QiitaGetRequestable {
    public var useAccessToken: Bool {
        return false
    }
    
    public var httpMethod: HttpMethod {
        return .get
    }
}
