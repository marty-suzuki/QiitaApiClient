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
    case UsersUserIdFollowers(userId: String, page: Int, perPage: Int)
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
        case .UsersUserIdFollowingTags(let value):
            return"/users/\(value.userId)/following_tags"
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
        case .ItemsItemIdStockers(let value):
            return "/items/\(value.itemId)/stockers"
        case .Users:
            return "/users"
        case .UsersUserId(let userId):
            return "/users/" + userId
        case .UsersUserIdFollowees(let userId):
            return "/users/\(userId)/followees"
        case .UsersUserIdFollowers(let value):
            return "/users/\(value.userId)/followers"
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
        case .TagsTagIdItems(let value):
            return "/tags/\(value.tagId)/items"
        case .UsersUserIdItems(let value):
            return "/users/\(value.userId)/items"
        case .UsersUserIdStocks(let value):
            return "/users/\(value.userId)/stocks"
        }
    }
    
    var queryString: String {
        switch self {
        case .QauthAuthorize(let value):
            return convertParametersToString(
                QiitaURLQueryParameter(name: "client_id", value: value.clientId),
                QiitaURLQueryParameter(name: "scope", value: value.scope, needsEncode: false),
                QiitaURLQueryParameter(name: "state", value: value.state)
            )
        case .Tags(let value):
            let sortParameter = QiitaURLQueryParameter(name: "sort", value: value.sort.rawValue)
            return pageParameters(value.page, perPage: value.perPage, otherParameters: [sortParameter])
        case .UsersUserIdFollowingTags(let value):
            return pageParameters(value.page, perPage: value.perPage)
        case .Templates(let value):
            return pageParameters(value.page, perPage: value.perPage)
        case .Projects(let value):
            return pageParameters(value.page, perPage: value.perPage)
        case .ItemsItemIdStockers(let value):
            return pageParameters(value.page, perPage: value.perPage)
        case .Users(let value):
            return pageParameters(value.page, perPage: value.perPage)
        case .UsersUserIdFollowees(let value):
            return pageParameters(value.page, perPage: value.perPage)
        case .UsersUserIdFollowers(let value):
            return pageParameters(value.page, perPage: value.perPage)
        case .AuthenticatedUserItems(let value):
            return pageParameters(value.page, perPage: value.perPage)
        case .Items(let value):
            let searchQueries: [String] = value.query.flatMap { $0.toString() }
            let searchQueryString = searchQueries.reduce("") { $0 == "" ? $1 : $0 + "+" + $1 }
            let searchQueryParameter = QiitaURLQueryParameter(name: "query", value: searchQueryString, needsEncode: false)
            return pageParameters(value.page, perPage: value.perPage, otherParameters: [searchQueryParameter])
        case .TagsTagIdItems(let value):
            return pageParameters(value.page, perPage: value.perPage)
        case .UsersUserIdItems(let value):
            return pageParameters(value.page, perPage: value.perPage)
        case .UsersUserIdStocks(let value):
            return pageParameters(value.page, perPage: value.perPage)
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
