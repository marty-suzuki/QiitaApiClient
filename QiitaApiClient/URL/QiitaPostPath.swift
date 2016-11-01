//
//  QiitaPostPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaPostPath: QiitaPathStringReturnable, QiitaDictionaryRepresentable {
    case accessTokens(clientId: String, clientSecret: String, code: String)
    case itemsItemIdComments(itemId: String, body: String)
    case itemsItemIdTaggings(itemId: String, name: String, versions: [String])
    case templates(body: String, name: String, tags: [QiitaTagging], title: String)
    case projects(archived: Bool, body: String, name: String, tags: [QiitaTagging])
    case expandedTemplates(body: String, tags: [QiitaTagging], title: String)
    case items(body: String, coediting: Bool, gist: Bool, `private`: Bool, tags: [QiitaTagging], title: String, tweet: Bool)
    
    var pathString: String {
        switch self {
        case .accessTokens:
            return "/access_tokens"
        case .itemsItemIdComments(let itemId):
            return "/items/\(itemId)/comments"
        case .itemsItemIdTaggings(let itemId, _, _):
            return "/items/\(itemId)/taggings"
        case .templates:
            return "/templates"
        case .projects:
            return "/projects"
        case .expandedTemplates:
            return "/expanded_templates"
        case .items:
            return "/items"
        }
    }
    
    var dictionary: [AnyHashable : Any] {
        switch self {
        case .accessTokens(let clientId, let clientSecret, let code):
            return [
                "client_id": clientId,
                "client_secret": clientSecret,
                "code": code
            ]
        case .itemsItemIdTaggings(_, let name, let versions):
            return [
                "name" : name,
                "versions" : versions
            ]
        case .itemsItemIdComments(_, let body):
            return [
                "body" : body
            ]
        case .templates(let body, let name, let tags, let title):
            let tags: [[AnyHashable : Any]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : body,
                "name" : name,
                "tags" : tags,
                "title" : title
            ]
        case .projects(let archived, let body, let name, let tags):
            let tags: [[AnyHashable : Any]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "archived" : archived,
                "body" : body,
                "name" : name,
                "tags" : tags
            ]
        case .expandedTemplates(let body, let tags, let title):
            let tags: [[AnyHashable : Any]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : body,
                "tags" : tags,
                "title" : title
            ]
        case .items(let body, let coediting, let gist, let `private`, let tags, let title, let tweet):
            let tags: [[AnyHashable : Any]] = tags.flatMap { $0.dictionaryRepresentation() }
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
