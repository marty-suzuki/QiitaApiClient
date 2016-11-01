//
//  QiitaItem.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

open class QiitaItem: QiitaModel {
    open let renderedBody: String
    open let body: String
    open let coediting: Bool
    open let createdAt: Date
    open let group: QiitaGroup?
    open let id: String
    open let `private`: Bool
    open let tags: [QiitaTagging]
    open let title: String
    open let updatedAt: Date
    open let url: URL
    open let user: QiitaUser
    
    public required init?(dictionary: [AnyHashable : Any]) {
        guard
            let renderedBody = dictionary["rendered_body"] as? String,
            let body = dictionary["body"] as? String,
            let coediting = dictionary["coediting"] as? Bool,
            let rawCreatedAt = dictionary["created_at"] as? String,
            let createdAt = Date.dateFromISO8601String(rawCreatedAt),
            let id = dictionary["id"] as? String,
            let `private` = dictionary["private"] as? Bool,
            let rawTags = dictionary["tags"] as? [[AnyHashable : Any]],
            let title = dictionary["title"] as? String,
            let rawUpdatedAt = dictionary["updated_at"] as? String,
            let updatedAt = Date.dateFromISO8601String(rawUpdatedAt),
            let rawUrl = dictionary["url"] as? String,
            let url = URL(string: rawUrl),
            let rawUser = dictionary["user"] as? [AnyHashable : Any],
            let user = QiitaUser(dictionary: rawUser)
        else {
            return nil
        }
        self.renderedBody = renderedBody
        self.body = body
        self.coediting = coediting
        self.createdAt = createdAt
        if let rawGroup = dictionary["group"] as? [AnyHashable : Any] {
            self.group = QiitaGroup(dictionary: rawGroup)
        } else {
            self.group = nil
        }
        self.id = id
        self.`private` = `private`
        let tags: [QiitaTagging] = rawTags.flatMap { QiitaTagging(dictionary: $0) }
        self.tags = tags
        self.title = title
        self.updatedAt = updatedAt
        self.url = url
        self.user = user
    }
}
