//
//  QiitaPatchPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaPatchPath: QiitaPathStringReturnable {
    case CommentsCommentId(commentId: String, body: String)
    case TemplatesTemplateId(templateId: Int, body: String, name: String, tags: [QiitaTagging], title: String)
    case ProjectsProjectId(progectId: Int, archived: Bool, body: String, name: String, tags: [QiitaTagging])
    case ItemsItemId(itemId: String, body: String, coediting: Bool, `private`: Bool, tags: [QiitaTagging], title: String)
    
    var pathString: String {
        switch self {
        case .CommentsCommentId(let commentId, _):
            return "/comments/\(commentId)"
        case .TemplatesTemplateId(let templateId, _, _, _, _):
            return "/templates/\(templateId)"
        case .ProjectsProjectId(let progectId, _, _, _, _):
            return "/projects/\(progectId)"
        case .ItemsItemId(let itemId, _, _, _, _, _):
            return "/items/" + itemId
        }
    }
    
    var dictionary: [String : NSObject] {
        switch self {
        case .CommentsCommentId(_, let body):
            return [
                "body": body
            ]
        case .TemplatesTemplateId(_, let body, let name, let tags, let title):
            let tags: [[String : NSObject]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : body,
                "name" : name,
                "tags" : tags,
                "title" : title
            ]
        case .ProjectsProjectId(_, let archived, let body, let name, let tags):
            let tags: [[String : NSObject]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "archived" : archived,
                "body" : body,
                "name" : name,
                "tags" : tags
            ]
        case .ItemsItemId(_, let body, let coediting, let `private`, let tags, let title):
            let tags: [[String : NSObject]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : body,
                "coediting" : coediting,
                "private" : `private`,
                "tags" : tags,
                "title" : title
            ]
        }
    }
}