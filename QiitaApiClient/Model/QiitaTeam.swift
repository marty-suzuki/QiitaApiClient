//
//  QiitaTeam.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

open class QiitaTeam: QiitaModel {
    open let active: Bool
    open let id: String
    open let name: String
    
    public required init?(dictionary: [AnyHashable : Any]) {
        guard
            let active = dictionary["active"] as? Bool,
            let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String
        else {
            return nil
        }
        self.active = active
        self.id = id
        self.name = name
    }
}
