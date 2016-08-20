//
//  QiitaTeam.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

public class QiitaTeam: QiitaModel {
    public let active: Bool
    public let id: String
    public let name: String
    
    public required init?(dictionary: [String : NSObject]) {
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