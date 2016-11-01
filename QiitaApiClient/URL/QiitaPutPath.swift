//
//  QiitaPutPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaPutPath: QiitaPathStringReturnable {
    case commentsCommentIdThank(commentId: String)
    case tagsTagIdFollowing(tagId: Int)
    case usersUserIdFollowing(userId: String)
    case itemsItemIdLike(itemId: String)
    case itemsItemIdStock(itemId: String)
    
    var pathString: String {
        switch self {
        case .commentsCommentIdThank(let commentId):
            return "/comments/\(commentId)/thank"
        case .tagsTagIdFollowing(let tagId):
            return "/tags/\(tagId)/following"
        case .usersUserIdFollowing(let userId):
            return "/users/\(userId)/following"
        case .itemsItemIdLike(let itemId):
            return "/items/\(itemId)/like"
        case .itemsItemIdStock(let itemId):
            return "/items/\(itemId)/stock"
        }
    }
}
