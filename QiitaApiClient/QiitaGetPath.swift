//
//  QiitaGetPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaGetPath: PathStringReturnable {
    case QauthAuthorize(clientId: String, scope: String, state: String?)
    case AuthenticatedUser
    
    var pathString: String {
        switch self {
        case .QauthAuthorize: return "/oauth/authorize"
        case .AuthenticatedUser: return "/authenticated_user"
        }
    }
    
    var queryString: String {
        switch self {
        case .QauthAuthorize(let clientId, let scope, let state):
            return convertParametersToString(
                QiitaURLQueryParameter(name: "client_id", value: clientId),
                QiitaURLQueryParameter(name: "scope", value: scope, needsEncode: false),
                QiitaURLQueryParameter(name: "state", value: state)
            )
        case .AuthenticatedUser:
            return ""
        }
    }
    
    var absoluteString: String {
        return pathString + (queryString.isEmpty ? "" : "?" + queryString)
    }
}
