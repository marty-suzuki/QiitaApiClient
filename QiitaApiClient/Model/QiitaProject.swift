//
//  QiitaProject.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

open class QiitaProject: QiitaModel {
    open let renderedBody: String
    open let archived: Bool
    open let body: String
    open let createdAt: Date
    open let id: Int
    open let name: String
    open let updatedAt: Date
    
    public required init?(dictionary: [AnyHashable : Any]) {
        guard
            let renderedBody = dictionary["rendered_body"] as? String,
            let archived = dictionary["archived"] as? Bool,
            let body = dictionary["body"] as? String,
            let rawCreatedAt = dictionary["created_at"] as? String,
            let createdAt = Date.dateFromISO8601String(rawCreatedAt),
            let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let rawUpdatedAt = dictionary["updated_at"] as? String,
            let updatedAt = Date.dateFromISO8601String(rawUpdatedAt)
        else {
            return nil
        }
        self.renderedBody = renderedBody
        self.archived = archived
        self.body = body
        self.createdAt = createdAt
        self.id = id
        self.name = name
        self.updatedAt = updatedAt
    }
}
