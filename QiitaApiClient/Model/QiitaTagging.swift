//
//  QiitaTagging.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

public class QiitaTagging: QiitaModel {
    public let name: String
    public let versions: [String]
    
    public required init?(dictionary: [String : NSObject]) {
        guard
            let name = dictionary["name"] as? String,
            let versions = dictionary["versions"] as? [String]
        else {
            return nil
        }
        self.name = name
        self.versions = versions
    }
}