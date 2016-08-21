//
//  QiitaDeletePath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

public enum QiitaDeletePath: QiitaPathStringReturnable {
    case AccessTokens(accessToken: String)
    case CommentsCommentId(commentId: String)
    case CommentsCommentIdThank(commentId: String)
    case ItemsItemIdTaggingsTaggingId(itemId: String, taggingId: Int)
    case TagsTagIdFollowing(tagId: Int)
    case TemplatesTemplateId(templateId: Int)
    case ProjectsProjectId(progectId: Int)
    case UsersUserIdFollowing(userId: String)
    case ItemsItemId(itemId: String)
    case ItemsItemIdLike(itemId: String)
    case ItemsItemIdStock(itemId: String)
    
    var pathString: String {
        switch self {
        case .AccessTokens(let accessToken):
            return "/access_tokens/" + accessToken
        case .CommentsCommentId(let commentId):
            return "/comments/\(commentId)"
        case .CommentsCommentIdThank(let commentId):
            return "/comments/\(commentId)/thank"
        case .ItemsItemIdTaggingsTaggingId(let itemId, let taggingId):
            return "/items/\(itemId)/taggings/\(taggingId)"
        case .TagsTagIdFollowing(let tagId):
            return "/tags/\(tagId)/following"
        case .TemplatesTemplateId(let templateId):
            return "/templates/\(templateId)"
        case .ProjectsProjectId(let progectId):
            return "/projects/\(progectId)"
        case .UsersUserIdFollowing(let userId):
            return "/users/\(userId)/following"
        case .ItemsItemId(let itemId):
            return "/items/" + itemId
        case .ItemsItemIdLike(let itemId):
            return "/items/\(itemId)/like"
        case .ItemsItemIdStock(let itemId):
            return "/items/\(itemId)/stock"
        }
    }
}