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
    
    public enum SearchQuery {
        case User(String)
        case Word(String)
        
        func toString() -> String {
            switch self {
            case .User(let name):
                return ("user:" + name).RFC3986Encode
            case .Word(let word):
                return word.RFC3986Encode
            }
        }
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
    case Templates(page: Int, perPage: Int)
    case TemplatesTemplateId(templateId: Int)
    case Projects(page: Int, perPage: Int)
    case ProjectsProjectId(progectId: Int)
    case ItemsItemIdStockers(itemId: String, page: Int, perPage: Int)
    case Users(page: Int, perPage: Int)
    case UsersUserId(userId: String)
    case UsersUserIdFollowees(userId: String, page: Int, perPage: Int)
    case UsersUserIdFollowers(uesrId: String, page: Int, perPage: Int)
    case UsersUserIdFollowing(userId: String)
    case AuthenticatedUserItems(page: Int, perPage: Int)
    case Items(page: Int, perPage: Int, query: [SearchQuery])
    case ItemsItemId(itemId: String)
    case ItemsItemIdStock(itemId: String)
    case ItemsItemIdLike(itemId: String)
    case TagsTagIdItems(tagId: Int, page: Int, perPage: Int)
    case UsersUserIdItems(userId: String, page: Int, perPage: Int)
    case UsersUserIdStocks(userId: String, page: Int, perPage: Int)
    
    var needAuthenticate: Bool {
        switch  self {
        case .AuthenticatedUser, .AuthenticatedUserItems:
            return true
        default:
            return false
        }
    }
    
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
        case .Templates:
            return "/templates"
        case .TemplatesTemplateId(let templateId):
            return "/templates/\(templateId)"
        case .Projects:
            return "/projects"
        case .ProjectsProjectId(let progectId):
            return "/projects/\(progectId)"
        case .ItemsItemIdStockers(let itemId, _, _):
            return "/items/\(itemId)/stockers"
        case .Users:
            return "/users"
        case .UsersUserId(let userId):
            return "/users/" + userId
        case .UsersUserIdFollowees(let userId):
            return "/users/\(userId)/followees"
        case .UsersUserIdFollowers(let userId, _, _):
            return "/users/\(userId)/followers"
        case .UsersUserIdFollowing(let userId):
            return "/users/\(userId)/following"
        case .AuthenticatedUserItems:
            return "/authenticated_user/items"
        case .Items:
            return "/items"
        case .ItemsItemId(let itemId):
            return "/items/" + itemId
        case .ItemsItemIdStock(let itemId):
            return "/items/\(itemId)/stock"
        case .ItemsItemIdLike(let itemId):
            return "/items/\(itemId)/like"
        case .TagsTagIdItems(let tagId, _, _):
            return "/tags/\(tagId)/items"
        case .UsersUserIdItems(let userId, _, _):
            return "/users/\(userId)/items"
        case .UsersUserIdStocks(let userId, _, _):
            return "/users/\(userId)/stocks"
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
            let sortParameter = QiitaURLQueryParameter(name: "sort", value: sort.rawValue)
            return pageParameters(page, perPage: perPage, otherParameters: [sortParameter])
        case .UsersUserIdFollowingTags(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .Templates(let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .Projects(let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .ItemsItemIdStockers(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .Users(let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .UsersUserIdFollowees(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .UsersUserIdFollowers(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .AuthenticatedUserItems(let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .Items(let page, let perPage, let query):
            let searchQueries: [String] = query.flatMap { $0.toString() }
            let searchQueryString = searchQueries.reduce("") { $0 == "" ? $1 : $0 + "+" + $1 }
            let searchQueryParameter = QiitaURLQueryParameter(name: "query", value: searchQueryString, needsEncode: false)
            return pageParameters(page, perPage: perPage, otherParameters: [searchQueryParameter])
        case .TagsTagIdItems(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .UsersUserIdItems(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .UsersUserIdStocks(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .AuthenticatedUser,
             .ItemsItemIdLikes,
             .CommentsCommentId,
             .ItemsItemIdComments,
             .TagsTagId,
             .TagsTagIdFollowing,
             .Teams,
             .TemplatesTemplateId,
             .ProjectsProjectId,
             .UsersUserId,
             .UsersUserIdFollowing,
             .ItemsItemId,
             .ItemsItemIdLike,
             .ItemsItemIdStock:
            return ""
        }
    }
    
    var absoluteString: String {
        return pathString + (queryString.isEmpty ? "" : "?" + queryString)
    }
    
    private func pageParameters(page: Int, perPage: Int, otherParameters: [QiitaURLQueryParameter?] = []) -> String {
        let parameters: [QiitaURLQueryParameter?] = Array([
            [
                QiitaURLQueryParameter(name: "page", value: page),
                QiitaURLQueryParameter(name: "per_page", value: perPage)
            ],
            otherParameters
        ].flatten())
        return convertParametersToString(parameters)
    }
}
