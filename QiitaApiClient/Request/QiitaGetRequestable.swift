//
//  QiitaGetRequestable.swift
//  Pods
//
//  Created by 鈴木 大貴 on 2016/11/28.
//
//

import Foundation

protocol QiitaGetRequestable: QiitaRequestable {}

extension QiitaGetRequestable {
    var useAccessToken: Bool {
        return false
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
}
