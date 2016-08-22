//
//  QiitaHttpMethod.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaHttpMethod {
    case Get   (QiitaGetPath)
    case Post  (QiitaPostPath)
    case Delete(QiitaDeletePath)
    case Patch (QiitaPatchPath)
    case Put   (QiitaPutPath)
    
    var needAuthenticate: Bool {
        switch self {
        case .Delete, .Patch, .Post, .Put:
            return true
        case .Get(let path):
            return path.needAuthenticate
        }
    }
}
