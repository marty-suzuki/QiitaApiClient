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
        case count = "count"
        case name = "name"
    }
    
    public enum SearchQuery {
        case user(String)
        case word(String)
        
        func toString() -> String {
            switch self {
            case .user(let name):
                return ("user:" + name).RFC3986Encode
            case .word(let word):
                return word.RFC3986Encode
            }
        }
    }
    
    case qauthAuthorize(clientId: String, scope: String, state: String?)
    case authenticatedUser
    case itemsItemIdLikes(itemId: String)
    case commentsCommentId(commentId: String)
    case itemsItemIdComments(itemId: String)
    case tags(page: Int, perPage: Int, sort: Sort)
    case tagsTagId(tagId: Int)
    case usersUserIdFollowingTags(userId: String, page: Int, perPage: Int)
    case tagsTagIdFollowing(tagId: Int)
    case teams
    case templates(page: Int, perPage: Int)
    case templatesTemplateId(templateId: Int)
    case projects(page: Int, perPage: Int)
    case projectsProjectId(progectId: Int)
    case itemsItemIdStockers(itemId: String, page: Int, perPage: Int)
    case users(page: Int, perPage: Int)
    case usersUserId(userId: String)
    case usersUserIdFollowees(userId: String, page: Int, perPage: Int)
    case usersUserIdFollowers(uesrId: String, page: Int, perPage: Int)
    case usersUserIdFollowing(userId: String)
    case authenticatedUserItems(page: Int, perPage: Int)
    case items(page: Int, perPage: Int, query: [SearchQuery])
    case itemsItemId(itemId: String)
    case itemsItemIdStock(itemId: String)
    case itemsItemIdLike(itemId: String)
    case tagsTagIdItems(tagId: Int, page: Int, perPage: Int)
    case usersUserIdItems(userId: String, page: Int, perPage: Int)
    case usersUserIdStocks(userId: String, page: Int, perPage: Int)
    
    var needAuthenticate: Bool {
        switch  self {
        case .authenticatedUser, .authenticatedUserItems:
            return true
        default:
            return false
        }
    }
    
    var pathString: String {
        switch self {
        case .qauthAuthorize:
            return "/oauth/authorize"
        case .authenticatedUser:
            return "/authenticated_user"
        case .itemsItemIdLikes(let itemId):
            return "/items/\(itemId)/likes"
        case .commentsCommentId(let commentId):
            return "/comments/\(commentId)"
        case .itemsItemIdComments(let itemId):
            return "/items/\(itemId)/comments"
        case .tags:
            return "/tags"
        case .tagsTagId(let tagId):
            return "/tags/\(tagId)"
        case .usersUserIdFollowingTags(let userId, _, _):
            return"/users/\(userId)/following_tags"
        case .tagsTagIdFollowing(let tagId):
            return "/tags/\(tagId)/following"
        case .teams:
            return "/teams"
        case .templates:
            return "/templates"
        case .templatesTemplateId(let templateId):
            return "/templates/\(templateId)"
        case .projects:
            return "/projects"
        case .projectsProjectId(let progectId):
            return "/projects/\(progectId)"
        case .itemsItemIdStockers(let itemId, _, _):
            return "/items/\(itemId)/stockers"
        case .users:
            return "/users"
        case .usersUserId(let userId):
            return "/users/" + userId
        case .usersUserIdFollowees(let userId):
            return "/users/\(userId)/followees"
        case .usersUserIdFollowers(let userId, _, _):
            return "/users/\(userId)/followers"
        case .usersUserIdFollowing(let userId):
            return "/users/\(userId)/following"
        case .authenticatedUserItems:
            return "/authenticated_user/items"
        case .items:
            return "/items"
        case .itemsItemId(let itemId):
            return "/items/" + itemId
        case .itemsItemIdStock(let itemId):
            return "/items/\(itemId)/stock"
        case .itemsItemIdLike(let itemId):
            return "/items/\(itemId)/like"
        case .tagsTagIdItems(let tagId, _, _):
            return "/tags/\(tagId)/items"
        case .usersUserIdItems(let userId, _, _):
            return "/users/\(userId)/items"
        case .usersUserIdStocks(let userId, _, _):
            return "/users/\(userId)/stocks"
        }
    }
    
    var queryString: String {
        switch self {
        case .qauthAuthorize(let clientId, let scope, let state):
            return convertParametersToString(
                QiitaURLQueryParameter(name: "client_id", value: clientId),
                QiitaURLQueryParameter(name: "scope", value: scope, needsEncode: false),
                QiitaURLQueryParameter(name: "state", value: state)
            )
        case .tags(let page, let perPage, let sort):
            let sortParameter = QiitaURLQueryParameter(name: "sort", value: sort.rawValue)
            return pageParameters(page, perPage: perPage, otherParameters: [sortParameter])
        case .usersUserIdFollowingTags(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .templates(let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .projects(let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .itemsItemIdStockers(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .users(let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .usersUserIdFollowees(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .usersUserIdFollowers(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .authenticatedUserItems(let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .items(let page, let perPage, let query):
            let searchQueries: [String] = query.flatMap { $0.toString() }
            let searchQueryString = searchQueries.reduce("") { $0 == "" ? $1 : $0 + "+" + $1 }
            let searchQueryParameter = QiitaURLQueryParameter(name: "query", value: searchQueryString, needsEncode: false)
            return pageParameters(page, perPage: perPage, otherParameters: [searchQueryParameter])
        case .tagsTagIdItems(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .usersUserIdItems(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .usersUserIdStocks(_, let page, let perPage):
            return pageParameters(page, perPage: perPage)
        case .authenticatedUser,
             .itemsItemIdLikes,
             .commentsCommentId,
             .itemsItemIdComments,
             .tagsTagId,
             .tagsTagIdFollowing,
             .teams,
             .templatesTemplateId,
             .projectsProjectId,
             .usersUserId,
             .usersUserIdFollowing,
             .itemsItemId,
             .itemsItemIdLike,
             .itemsItemIdStock:
            return ""
        }
    }
    
    var absoluteString: String {
        return pathString + (queryString.isEmpty ? "" : "?" + queryString)
    }
    
    fileprivate func pageParameters(_ page: Int, perPage: Int, otherParameters: [QiitaURLQueryParameter?] = []) -> String {
        let parameters: [QiitaURLQueryParameter?] = Array([
            [
                QiitaURLQueryParameter(name: "page", value: page),
                QiitaURLQueryParameter(name: "per_page", value: perPage)
            ],
            otherParameters
        ].joined())
        return convertParametersToString(parameters)
    }
}
