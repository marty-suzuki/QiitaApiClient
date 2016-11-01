//
//  QiitaTag.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

open class QiitaTag: QiitaModel {
    open let followersCount: Int
    open let iconUrl: String?
    open let id: Int
    open let itemsCount: Int
    
    public required init?(dictionary: [AnyHashable : Any]) {
        guard
            let followersCount = dictionary["followers_count"] as? Int,
            let id = dictionary["id"] as? Int,
            let itemsCount = dictionary["items_count"] as? Int
        else {
                return nil
        }
        self.followersCount = followersCount
        self.iconUrl = dictionary["icon_url"] as? String
        self.id = id
        self.itemsCount = itemsCount
    }
}
