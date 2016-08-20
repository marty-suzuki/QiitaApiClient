//
//  QiitaLike.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

public class QiitaLike: QiitaModel {
    public let createdAt: NSDate
    public let user: QiitaUser
    
    public required init?(dictionary: [String : NSObject]) {
        guard
            let rawCreatedAt = dictionary["created_at"] as? String,
            let createdAt = NSDate.dateFromISO8601String(rawCreatedAt),
            let rawUser = dictionary["user"] as? [String : NSObject],
            let user = QiitaUser(dictionary: rawUser)
        else {
            return nil
        }        
        self.createdAt = createdAt
        self.user = user
    }
}