//
//  QiitaGroup.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

open class QiitaGroup: QiitaModel {
    open let createdAt: Date
    open let id: Int
    open let name: String
    open let `private`: Bool
    open let updatedAt: Date
    open let urlName: String
    
    public required init?(dictionary: [AnyHashable : Any]) {
       guard
            let rawCreatedAt = dictionary["created_at"] as? String,
            let createdAt = Date.dateFromISO8601String(rawCreatedAt),
            let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let `private` = dictionary["private"] as? Bool,
            let rawUpdatedAt = dictionary["updated_at"] as? String,
            let updatedAt = Date.dateFromISO8601String(rawUpdatedAt),
            let urlName = dictionary["url_name"] as? String
        else {
            return nil
        }
        self.createdAt = createdAt
        self.id = id
        self.name = name
        self.`private` = `private`
        self.updatedAt = updatedAt
        self.urlName = urlName
    }
}
