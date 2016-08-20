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
    
    var pathString: String {
        switch self {
        case .CommentsCommentId(let commentId, _):
            return "/comments/\(commentId)"
        }
    }
    
    var dictionary: [String : NSObject] {
        switch self {
        case .CommentsCommentId(_, let body):
            return [
                "body": body
            ]
        }
    }
}