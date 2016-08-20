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
        }
    }
}