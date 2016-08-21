//
//  QiitaTagging.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

public class QiitaTagging: QiitaModel {
    private struct Const {
        static let name = "name"
        static let versions = "versions"
    }
    
    public let name: String
    public let versions: [String]
    
    public required init?(dictionary: [String : NSObject]) {
        guard
            let name = dictionary[Const.name] as? String,
            let versions = dictionary[Const.versions] as? [String]
        else {
            return nil
        }
        self.name = name
        self.versions = versions
    }
    
    public init(name: String, versions: [String]) {
        self.name = name
        self.versions = versions
    }
    
    func dictionaryRepresentation() -> [String : NSObject] {
        return [
            Const.name : name,
            Const.versions : versions
        ]
    }
}