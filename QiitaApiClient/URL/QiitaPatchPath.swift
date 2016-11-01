//
//  QiitaPatchPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaPatchPath: QiitaPathStringReturnable, QiitaDictionaryRepresentable {
    case commentsCommentId(commentId: String, body: String)
    case templatesTemplateId(templateId: Int, body: String, name: String, tags: [QiitaTagging], title: String)
    case projectsProjectId(progectId: Int, archived: Bool, body: String, name: String, tags: [QiitaTagging])
    case itemsItemId(itemId: String, body: String, coediting: Bool, `private`: Bool, tags: [QiitaTagging], title: String)
    
    var pathString: String {
        switch self {
        case .commentsCommentId(let commentId, _):
            return "/comments/\(commentId)"
        case .templatesTemplateId(let templateId, _, _, _, _):
            return "/templates/\(templateId)"
        case .projectsProjectId(let progectId, _, _, _, _):
            return "/projects/\(progectId)"
        case .itemsItemId(let itemId, _, _, _, _, _):
            return "/items/" + itemId
        }
    }
    
    var dictionary: [AnyHashable : Any] {
        switch self {
        case .commentsCommentId(_, let body):
            return [
                "body": body
            ]
        case .templatesTemplateId(_, let body, let name, let tags, let title):
            let tags: [[AnyHashable : Any]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "body" : body,
                "name" : name,
                "tags" : tags,
                "title" : title
            ]
        case .projectsProjectId(_, let archived, let body, let name, let tags):
            let tags: [[AnyHashable : Any]] = tags.flatMap { $0.dictionaryRepresentation() }
            return [
                "archived" : archived,
                "body" : body,
                "name" : name,
                "tags" : tags
            ]
        case .itemsItemId(_, let body, let coediting, let `private`, let tags, let title):
            let tags: [[AnyHashable : Any]] = tags.flatMap { $0.dictionaryRepresentation() }
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
