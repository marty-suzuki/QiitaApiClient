//
//  QiitaApplicationInfo.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

class QiitaApplicationInfo {
    fileprivate struct Const {
        static let qiitaCodeKey = "qiita_code"
        static let qiitaAccessTokenKey = "qiita_access_token"
    }
    
    static let `default`: QiitaApplicationInfo = .init()
    
    let clientId: String
    let clientSecret: String
    let redirectURL: String
    let scope: String
    var code: String? {
        get {
            return UserDefaults.standard.string(forKey: Const.qiitaCodeKey)
        }
        set {
            let ud = UserDefaults.standard
            ud.set(newValue, forKey: Const.qiitaCodeKey)
            ud.synchronize()
        }
    }
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Const.qiitaAccessTokenKey)
        }
        set {
            let ud = UserDefaults.standard
            ud.set(newValue, forKey: Const.qiitaAccessTokenKey)
            ud.synchronize()
        }
    }
    
    fileprivate init() {
        guard let infoDict = Bundle.main.infoDictionary?["QiitaApplicaiontInfo"] as? [String : NSObject] else {
            fatalError("can not find Qiita Applicaiont Info")
        }
        guard let clientId = infoDict["client_id"] as? String, !clientId.isEmpty else {
            fatalError("can not find Qiita Applicationt Client Id")
        }
        guard let clientSecret = infoDict["client_secret"] as? String, !clientSecret.isEmpty else {
            fatalError("can not find Qiita Applicationt Client Secret")
        }
        guard let redirectURL = infoDict["redirect_url"] as? String, !redirectURL.isEmpty else {
            fatalError("can not find Qiita Applicationt redirect URL")
        }
        guard let rawScope = infoDict["scope"] as? [String] else {
            fatalError("can not find Qiita Application scope")
        }
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.redirectURL = redirectURL
        let scopes: [QiitaAuthorizeScope] = rawScope.map {
            guard let scope = QiitaAuthorizeScope(rawValue: $0) else {
                fatalError("invalid scope string \"\($0)\"")
            }
            return scope
        }
        let scopeStrings: [String] = scopes.map { $0.rawValue }
        let scopeString: String = scopeStrings.reduce("") { $0 == "" ? $1 : $0 + "+" + $1 }
        self.scope = scopeString
    }
}
