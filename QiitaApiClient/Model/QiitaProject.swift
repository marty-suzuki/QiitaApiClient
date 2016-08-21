//
//  QiitaProject.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

public class QiitaProject: QiitaModel {
    public let renderedBody: String
    public let archived: Bool
    public let body: String
    public let createdAt: NSDate
    public let id: Int
    public let name: String
    public let updatedAt: NSDate
    
    public required init?(dictionary: [String : NSObject]) {
        guard
            let renderedBody = dictionary["rendered_body"] as? String,
            let archived = dictionary["archived"] as? Bool,
            let body = dictionary["body"] as? String,
            let rawCreatedAt = dictionary["created_at"] as? String,
            let createdAt = NSDate.dateFromISO8601String(rawCreatedAt),
            let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let rawUpdatedAt = dictionary["updated_at"] as? String,
            let updatedAt = NSDate.dateFromISO8601String(rawUpdatedAt)
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