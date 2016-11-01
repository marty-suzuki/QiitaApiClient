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
    case post  (QiitaPostPath)
    case delete(QiitaDeletePath)
    case patch (QiitaPatchPath)
    case put   (QiitaPutPath)
    
    var needAuthenticate: Bool {
        switch self {
        case .delete, .patch, .post, .put:
            return true
        case .get(let path):
            return path.needAuthenticate
        }
    }
}
