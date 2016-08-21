//
//  QiitaGroup.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

public class QiitaGroup: QiitaModel {
    public let createdAt: NSDate
    public let id: Int
    public let name: String
    public let `private`: Bool
    public let updatedAt: NSDate
    public let urlName: String
    
    public required init?(dictionary: [String : NSObject]) {
       guard
            let rawCreatedAt = dictionary["created_at"] as? String,
            let createdAt = NSDate.dateFromISO8601String(rawCreatedAt),
            let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let `private` = dictionary["private"] as? Bool,
            let rawUpdatedAt = dictionary["updated_at"] as? String,
            let updatedAt = NSDate.dateFromISO8601String(rawUpdatedAt),
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