//
//  QiitaPutRequestable.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/11/29.
//
//

import Foundation

public protocol QiitaPutRequestable: QiitaRequestable {}

extension QiitaPutRequestable {
    public var useAccessToken: Bool {
        return true
    }
    
    public var httpMethod: HttpMethod {
        return .put
    }
}
