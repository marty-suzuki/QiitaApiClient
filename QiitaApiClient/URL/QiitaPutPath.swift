//
//  QiitaPutPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaPutPath: QiitaPathStringReturnable {
    case CommentsCommentIdThank(commentId: String)
    case TagsTagIdFollowing(tagId: Int)
    case UsersUserIdFollowing(userId: String)
    case ItemsItemIdLike(itemId: String)
    case ItemsItemIdStock(itemId: String)
    
    var pathString: String {
        switch self {
        case .CommentsCommentIdThank(let commentId):
            return "/comments/\(commentId)/thank"
        case .TagsTagIdFollowing(let tagId):
            return "/tags/\(tagId)/following"
        case .UsersUserIdFollowing(let userId):
            return "/users/\(userId)/following"
        case .ItemsItemIdLike(let itemId):
            return "/items/\(itemId)/like"
        case .ItemsItemIdStock(let itemId):
            return "/items/\(itemId)/stock"
        }
    }
}