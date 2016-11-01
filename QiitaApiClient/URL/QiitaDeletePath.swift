//
//  QiitaDeletePath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

public enum QiitaDeletePath: QiitaPathStringReturnable {
    case accessTokens(accessToken: String)
    case commentsCommentId(commentId: String)
    case commentsCommentIdThank(commentId: String)
    case itemsItemIdTaggingsTaggingId(itemId: String, taggingId: Int)
    case tagsTagIdFollowing(tagId: Int)
    case templatesTemplateId(templateId: Int)
    case projectsProjectId(progectId: Int)
    case usersUserIdFollowing(userId: String)
    case itemsItemId(itemId: String)
    case itemsItemIdLike(itemId: String)
    case itemsItemIdStock(itemId: String)
    
    var pathString: String {
        switch self {
        case .accessTokens(let accessToken):
            return "/access_tokens/" + accessToken
        case .commentsCommentId(let commentId):
            return "/comments/\(commentId)"
        case .commentsCommentIdThank(let commentId):
            return "/comments/\(commentId)/thank"
        case .itemsItemIdTaggingsTaggingId(let itemId, let taggingId):
            return "/items/\(itemId)/taggings/\(taggingId)"
        case .tagsTagIdFollowing(let tagId):
            return "/tags/\(tagId)/following"
        case .templatesTemplateId(let templateId):
            return "/templates/\(templateId)"
        case .projectsProjectId(let progectId):
            return "/projects/\(progectId)"
        case .usersUserIdFollowing(let userId):
            return "/users/\(userId)/following"
        case .itemsItemId(let itemId):
            return "/items/" + itemId
        case .itemsItemIdLike(let itemId):
            return "/items/\(itemId)/like"
        case .itemsItemIdStock(let itemId):
            return "/items/\(itemId)/stock"
        }
    }
}
