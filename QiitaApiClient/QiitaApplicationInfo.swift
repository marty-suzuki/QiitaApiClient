//
//  QiitaApplicationInfo.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

class QiitaApplicationInfo {
    private struct Const {
        static let QiitaCodeKey = "qiita_code"
        static let QiitaAccessTokenKey = "qiita_access_token"
    }
    
    static let sharedInfo: QiitaApplicationInfo = .init()
    
    let clientId: String
    let clientSecret: String
    let redirectURL: String
    let scope: String
    var code: String? {
        get {
            return NSUserDefaults.standardUserDefaults().stringForKey(Const.QiitaCodeKey)
        }
        set {
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setObject(newValue, forKey: Const.QiitaCodeKey)
            ud.synchronize()
        }
    }
    var accessToken: String? {
        get {
            return NSUserDefaults.standardUserDefaults().stringForKey(Const.QiitaAccessTokenKey)
        }
        set {
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setObject(newValue, forKey: Const.QiitaAccessTokenKey)
            ud.synchronize()
        }
    }
    
    private init() {
        guard let infoDict = NSBundle.mainBundle().infoDictionary?["QiitaApplicaiontInfo"] as? [String : NSObject] else {
            fatalError("can not find Qiita Applicaiont Info")
        }
        guard let clientId = infoDict["client_id"] as? String where !clientId.isEmpty else {
            fatalError("can not find Qiita Applicationt Client Id")
        }
        guard let clientSecret = infoDict["client_secret"] as? String where !clientSecret.isEmpty else {
            fatalError("can not find Qiita Applicationt Client Secret")
        }
        guard let redirectURL = infoDict["redirect_url"] as? String where !redirectURL.isEmpty else {
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