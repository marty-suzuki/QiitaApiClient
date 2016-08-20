//
//  QiitaTag.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

public class QiitaTag: QiitaModel {
    public let followersCount: Int
    public let iconUrl: String?
    public let id: Int
    public let itemsCount: Int
    
    public required init?(dictionary: [String : NSObject]) {
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
