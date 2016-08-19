//
//  QiitaDeletePath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

public enum QiitaDeletePath: QiitaPathStringReturnable {
    case AccessTokens(accessToken: String)
    
    var pathString: String {
        switch self {
        case .AccessTokens(let accessToken):
            return "/access_tokens/" + accessToken
        }
    }
}