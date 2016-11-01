//
//  QiitaLike.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

open class QiitaLike: QiitaModel {
    open let createdAt: Date
    open let user: QiitaUser
    
    public required init?(dictionary: [AnyHashable : Any]) {
        guard
            let rawCreatedAt = dictionary["created_at"] as? String,
            let createdAt = Date.dateFromISO8601String(rawCreatedAt),
            let rawUser = dictionary["user"] as? [AnyHashable : Any],
            let user = QiitaUser(dictionary: rawUser)
        else {
            return nil
        }        
        self.createdAt = createdAt
        self.user = user
    }
}
