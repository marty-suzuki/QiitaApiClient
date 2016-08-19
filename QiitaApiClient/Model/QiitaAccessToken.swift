//
//  QiitaAccessToken.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

public enum QiitaAuthorizeScope: String {
    case ReadQiita      = "read_qiita"
    case ReadQiitaTeam  = "read_qiita_team"
    case WriteQiita     = "write_qiita"
    case WriteQiitaTeam = "write_qiita_team"
}

public class QiitaAccessToken: QiitaModel {
    public let clientId: String
    public let scopes: [QiitaAuthorizeScope]
    public let token: String
    
    public required init?(dictionary: [String : NSObject]) {
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