//
//  QiitaPostPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaPostPath: PathStringReturnable {
    case AccessTokens(clientId: String, clientSecret: String, code: String)
    
    var pathString: String {
        switch self {
        case .AccessTokens  : return "/access_tokens"
        }
    }
    
    var dictionary: [String : NSObject] {
        switch self {
        case .AccessTokens(let clientId, let clientSecret, let code):
            return [
                "client_id": clientId,
                "client_secret": clientSecret,
                "code": code
            ]
        }
    }
}
