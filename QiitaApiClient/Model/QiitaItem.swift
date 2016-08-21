//
//  QiitaItem.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

public class QiitaItem: QiitaModel {
    public let renderedBody: String
    public let body: String
    public let coediting: Bool
    public let createdAt: NSDate
    public let group: QiitaGroup?
    public let id: String
    public let `private`: Bool
    public let tags: [QiitaTagging]
    public let title: String
    public let updatedAt: NSDate
    public let url: NSURL
    public let user: QiitaUser
    
    public required init?(dictionary: [String : NSObject]) {
        guard
            let renderedBody = dictionary["rendered_body"] as? String,
            let body = dictionary["body"] as? String,
            let coediting = dictionary["coediting"] as? Bool,
            let rawCreatedAt = dictionary["created_at"] as? String,
            let createdAt = NSDate.dateFromISO8601String(rawCreatedAt),
            let id = dictionary["id"] as? String,
            let `private` = dictionary["private"] as? Bool,
            let rawTags = dictionary["tags"] as? [[String : NSObject]],
            let title = dictionary["title"] as? String,
            let rawUpdatedAt = dictionary["updated_at"] as? String,
            let updatedAt = NSDate.dateFromISO8601String(rawUpdatedAt),
            let rawUrl = dictionary["url"] as? String,
            let url = NSURL(string: rawUrl),
            let rawUser = dictionary["user"] as? [String : NSObject],
            let user = QiitaUser(dictionary: rawUser)
        else {
            return nil
        }
        self.renderedBody = renderedBody
        self.body = body
        self.coediting = coediting
        self.createdAt = createdAt
        if let rawGroup = dictionary["group"] as? [String : NSObject] {
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