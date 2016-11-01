//
//  QiitaAccessToken.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

public enum QiitaAuthorizeScope: String {
    case readQiita      = "read_qiita"
    case readQiitaTeam  = "read_qiita_team"
    case writeQiita     = "write_qiita"
    case writeQiitaTeam = "write_qiita_team"
}

open class QiitaAccessToken: QiitaModel {
    open let clientId: String
    open let scopes: [QiitaAuthorizeScope]
    open let token: String
    
    public required init?(dictionary: [AnyHashable : Any]) {
        guard
            let clientId = dictionary["client_id"] as? String,
            let rawScopes = dictionary["scopes"] as? [String],
            let token = dictionary["token"] as? String
        else {
            return nil
        }
        let scopes = rawScopes.flatMap { QiitaAuthorizeScope(rawValue: $0) }
        if scopes.count < 1 { return nil }
        self.clientId = clientId
        self.scopes = scopes
        self.token = token
    }
}
