//
//  QiitaPostPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaPostPath: QiitaPathStringReturnable, QiitaDictionaryRepresentable {
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
        case .ItemsItemIdTaggings(let value):
            return "/items/\(value.itemId)/taggings"
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
        case .AccessTokens(let value):
            return [
                "client_id": value.clientId,
                "client_secret": value.clientSecret,
                "code": value.code
            ]
        case .ItemsItemIdTaggings(let value):
            return [
                "name" : value.name,
                "versions" : value.versions
            ]
        case .ItemsItemIdComments(let value):
            return [
                "body" : value.body
            ]
        case .Templates(let value):
            let tags: [[String : NSObject]] = value.tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : value.body,
                "name" : value.name,
                "tags" : tags,
                "title" : value.title
            ]
        case .Projects(let value):
            let tags: [[String : NSObject]] = value.tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "archived" : value.archived,
                "body" : value.body,
                "name" : value.name,
                "tags" : tags
            ]
        case .ExpandedTemplates(let value):
            let tags: [[String : NSObject]] = value.tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : value.body,
                "tags" : tags,
                "title" : value.title
            ]
        case .Items(let value):
            let tags: [[String : NSObject]] = value.tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : value.body,
                "coediting" : value.coediting,
                "gist" : value.gist,
                "private" : value.`private`,
                "tags" : tags,
                "title" : value.title,
                "tweet" : value.tweet
            ]
        }
    }
}
