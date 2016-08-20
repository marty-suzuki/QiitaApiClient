//
//  QiitaGetPath.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

public enum QiitaGetPath: QiitaPathStringReturnable {
    public enum Sort: String {
        case Count = "count"
        case Name = "name"
    }
    
    case QauthAuthorize(clientId: String, scope: String, state: String?)
    case AuthenticatedUser
    case ItemsItemIdLikes(itemId: String)
    case CommentsCommentId(commentId: String)
    case ItemsItemIdComments(itemId: String)
    case Tags(page: Int, perPage: Int, sort: Sort)
    case TagsTagId(tagId: Int)
    case UsersUserIdFollowingTags(userId: String, page: Int, perPage: Int)
    case TagsTagIdFollowing(tagId: Int)
    case Teams
    
    var pathString: String {
        switch self {
        case .QauthAuthorize:
            return "/oauth/authorize"
        case .AuthenticatedUser:
            return "/authenticated_user"
        case .ItemsItemIdLikes(let itemId):
            return "/items/\(itemId)/likes"
        case .CommentsCommentId(let commentId):
            return "/comments/\(commentId)"
        case .ItemsItemIdComments(let itemId):
            return "/items/\(itemId)/comments"
        case .Tags:
            return "/tags"
        case .TagsTagId(let tagId):
            return "/tags/\(tagId)"
        case .UsersUserIdFollowingTags(let userId, _, _):
            return"/users/\(userId)/following_tags"
        case .TagsTagIdFollowing(let tagId):
            return "/tags/\(tagId)/following"
        case .Teams:
            return "/teams"
        }
    }
    
    var queryString: String {
        switch self {
        case .QauthAuthorize(let clientId, let scope, let state):
            return convertParametersToString(
                QiitaURLQueryParameter(name: "client_id", value: clientId),
                QiitaURLQueryParameter(name: "scope", value: scope, needsEncode: false),
                QiitaURLQueryParameter(name: "state", value: state)
            )
        case .Tags(let page, let perPage, let sort):
            return convertParametersToString(
                QiitaURLQueryParameter(name: "page", value: page),
                QiitaURLQueryParameter(name: "per_page", value: perPage),
                QiitaURLQueryParameter(name: "sort", value: sort.rawValue)
            )
        case .UsersUserIdFollowingTags(_, let page, let perPage):
            return convertParametersToString(
                QiitaURLQueryParameter(name: "page", value: page),
                QiitaURLQueryParameter(name: "per_page", value: perPage)
            )
        case .AuthenticatedUser,
             .ItemsItemIdLikes,
             .CommentsCommentId,
             .ItemsItemIdComments,
             .TagsTagId,
             .TagsTagIdFollowing,
             .Teams:
            return ""
        }
    }
    
    var absoluteString: String {
        return pathString + (queryString.isEmpty ? "" : "?" + queryString)
    }
}
