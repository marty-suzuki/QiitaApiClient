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
    
    var pathString: String {
        switch self {
        case .CommentsCommentIdThank(let commentId):
            return "/comments/\(commentId)/thank"
        case .TagsTagIdFollowing(let tagId):
            return "/tags/\(tagId)/following"
        }
    }
}