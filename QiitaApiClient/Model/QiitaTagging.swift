//
//  QiitaTagging.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

open class QiitaTagging: QiitaModel {
    fileprivate struct Const {
        static let name = "name"
        static let versions = "versions"
    }
    
    open let name: String
    open let versions: [String]
    
    public required init?(dictionary: [AnyHashable : Any]) {
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
    
    func dictionaryRepresentation() -> [AnyHashable : Any] {
        return [
            Const.name : name,
            Const.versions : versions
        ]
    }
}
