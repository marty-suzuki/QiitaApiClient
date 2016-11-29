//
//  QiitaDeleteRequestable.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/11/30.
//
//

import Foundation

public protocol QiitaDeleteRequestable: QiitaRequestable {}

extension QiitaDeleteRequestable {
    public var useAccessToken: Bool {
        return true
    }
    
    public var httpMethod: HttpMethod {
        return .delete
    }
}
