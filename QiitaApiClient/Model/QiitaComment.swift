//
//  QiitaComment.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

open class QiitaComment: QiitaModel {
    open let body: String
    open let createdAt: Date
    open let id: String
    open let renderedBody: String
    open let updatedAt: Date
    open let user: QiitaUser
    
    public required init?(dictionary: [AnyHashable : Any]) {
        guard
            let body = dictionary["body"] as? String,
            let rawCreatedAt = dictionary["created_at"] as? String,
            let createdAt = Date.dateFromISO8601String(rawCreatedAt),
            let id = dictionary["id"] as? String,
            let renderedBody = dictionary["rendered_body"] as? String,
            let rawUpdatedAt = dictionary["updated_at"] as? String,
            let updatedAt = Date.dateFromISO8601String(rawUpdatedAt),
            let rawUser = dictionary["user"] as? [AnyHashable : Any],
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
