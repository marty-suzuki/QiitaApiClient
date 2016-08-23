//
//  QiitaPatchPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaPatchPath: QiitaPathStringReturnable, QiitaDictionaryRepresentable {
    case CommentsCommentId(commentId: String, body: String)
    case TemplatesTemplateId(templateId: Int, body: String, name: String, tags: [QiitaTagging], title: String)
    case ProjectsProjectId(progectId: Int, archived: Bool, body: String, name: String, tags: [QiitaTagging])
    case ItemsItemId(itemId: String, body: String, coediting: Bool, `private`: Bool, tags: [QiitaTagging], title: String)
    
    var pathString: String {
        switch self {
        case .CommentsCommentId(let value):
            return "/comments/\(value.commentId)"
        case .TemplatesTemplateId(let value):
            return "/templates/\(value.templateId)"
        case .ProjectsProjectId(let value):
            return "/projects/\(value.progectId)"
        case .ItemsItemId(let value):
            return "/items/" + value.itemId
        }
    }
    
    var dictionary: [String : NSObject] {
        switch self {
        case .CommentsCommentId(let value):
            return [
                "body": value.body
            ]
        case .TemplatesTemplateId(let value):
            let tags: [[String : NSObject]] = value.tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : value.body,
                "name" : value.name,
                "tags" : tags,
                "title" : value.title
            ]
        case .ProjectsProjectId(let value):
            let tags: [[String : NSObject]] = value.tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "archived" : value.archived,
                "body" : value.body,
                "name" : value.name,
                "tags" : tags
            ]
        case .ItemsItemId(let value):
            let tags: [[String : NSObject]] = value.tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : value.body,
                "coediting" : value.coediting,
                "private" : value.`private`,
                "tags" : tags,
                "title" : value.title
            ]
        }
    }
}