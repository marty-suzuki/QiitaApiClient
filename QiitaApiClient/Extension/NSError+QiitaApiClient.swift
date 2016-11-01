//
//  NSError+QiitaApiClient.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//


import Foundation

extension NSError {
    fileprivate struct Const {
        static let message = "message"
        static let type = "type"
        static let url = "url"
    }
    
    struct ErrorDomain {
        static let invalidResponseData = ErrorDomain(code: 100001, domain: "QiitaInvalidResponseDataErrorDomain")
        static let invalidErrorData    = ErrorDomain(code: 100002, domain: "QiitaInvalidErrorDataErrorDomain")
        static let unknownStatusCode   = ErrorDomain(code: 100003, domain: "QiitaUnknownStatusCodeErrorDomain")
        static let notFindCode         = ErrorDomain(code: 100004, domain: "QiitaNotFindCodeErrorDomain")
        
        let code: Int
        let domain: String
    }
    
    convenience init(errorDomain: ErrorDomain) {
        self.init(domain: errorDomain.domain, code: errorDomain.code, userInfo: nil)
    }
    
    convenience init?(response: HTTPURLResponse,  dictionary: [AnyHashable : Any]) {
        guard
            let _ = dictionary[Const.message] as? String,
            let _ = dictionary[Const.type] as? String
        else {
            return nil
        }
        var userInfo = dictionary
        if let url = response.url?.absoluteString {
            userInfo[Const.url] = url as NSObject?
        }
        self.init(domain: "QiitaServerErrorDomain", code: 100000 + response.statusCode, userInfo: userInfo)
    }
    
    public var message: String? {
        return userInfo[Const.message] as? String
    }
    
    public var type: String? {
        return userInfo[Const.type] as? String
    }
    
    public var url: String? {
        return userInfo[Const.url] as? String
    }
}
