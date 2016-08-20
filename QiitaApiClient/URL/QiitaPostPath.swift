//
//  QiitaPostPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaPostPath: QiitaPathStringReturnable {
    case AccessTokens(clientId: String, clientSecret: String, code: String)
    case ItemsItemIdComments(itemId: String, body: String)
    case ItemsItemIdTaggings(itemId: String, name: String, versions: [String])
    
    var pathString: String {
        switch self {
        case .AccessTokens:
            return "/access_tokens"
        case .ItemsItemIdComments(let itemId):
            return "/items/\(itemId)/comments"
        case .ItemsItemIdTaggings(let itemId, _, _):
            return "/items/\(itemId)/taggings"
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
        case .ItemsItemIdTaggings(_, let name, let versions):
            return [
                "name" : name,
                "versions" : versions
            ]
        case .ItemsItemIdComments(_, let body):
            return [
                "body" : body
            ]
        }
    }
}
