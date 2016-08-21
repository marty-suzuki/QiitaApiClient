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
    case Templates(body: String, name: String, tags: [QiitaTagging], title: String)
    case Projects(archived: Bool, body: String, name: String, tags: [QiitaTagging])
    case ExpandedTemplates(body: String, tags: [QiitaTagging], title: String)
    case Items(body: String, coediting: Bool, gist: Bool, `private`: Bool, tags: [QiitaTagging], title: String, tweet: Bool)
    
    var pathString: String {
        switch self {
        case .AccessTokens:
            return "/access_tokens"
        case .ItemsItemIdComments(let itemId):
            return "/items/\(itemId)/comments"
        case .ItemsItemIdTaggings(let itemId, _, _):
            return "/items/\(itemId)/taggings"
        case .Templates:
            return "/templates"
        case .Projects:
            return "/projects"
        case .ExpandedTemplates:
            return "/expanded_templates"
        case .Items:
            return "/items"
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
        case .Templates(let body, let name, let tags, let title):
            let tags: [[String : NSObject]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : body,
                "name" : name,
                "tags" : tags,
                "title" : title
            ]
        case .Projects(let archived, let body, let name, let tags):
            let tags: [[String : NSObject]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "archived" : archived,
                "body" : body,
                "name" : name,
                "tags" : tags
            ]
        case .ExpandedTemplates(let body, let tags, let title):
            let tags: [[String : NSObject]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : body,
                "tags" : tags,
                "title" : title
            ]
        case .Items(let body, let coediting, let gist, let `private`, let tags, let title, let tweet):
            let tags: [[String : NSObject]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : body,
                "coediting" : coediting,
                "gist" : gist,
                "private" : `private`,
                "tags" : tags,
                "title" : title,
                "tweet" : tweet
            ]
        }
    }
}
