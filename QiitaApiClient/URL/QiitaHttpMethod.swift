//
//  QiitaHttpMethod.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaHttpMethod {
    case get   (QiitaGetPath)
    
    var needAuthenticate: Bool {
        switch self {
        case .get(let path):
            return path.needAuthenticate
        }
    }
}
