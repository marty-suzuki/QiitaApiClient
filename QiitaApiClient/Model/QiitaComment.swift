//
//  QiitaComment.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

public class QiitaComment: QiitaModel {
    public let body: String
    public let createdAt: NSDate
    public let id: String
    public let renderedBody: String
    public let updatedAt: NSDate
    public let user: QiitaUser
    
    public required init?(dictionary: [String : NSObject]) {
        guard
            let body = dictionary["body"] as? String,
            let rawCreatedAt = dictionary["created_at"] as? String,
            let createdAt = NSDate.dateFromISO8601String(rawCreatedAt),
            let id = dictionary["id"] as? String,
            let renderedBody = dictionary["rendered_body"] as? String,
            let rawUpdatedAt = dictionary["updated_at"] as? String,
            let updatedAt = NSDate.dateFromISO8601String(rawUpdatedAt),
            let rawUser = dictionary["user"] as? [String : NSObject],
            let user = QiitaUser(dictionary: rawUser)
        else {
            return nil
        }
        self.body = body
        self.createdAt = createdAt
        self.id = id
        self.renderedBody = renderedBody
        self.updatedAt = updatedAt
        self.user = user
    }
}