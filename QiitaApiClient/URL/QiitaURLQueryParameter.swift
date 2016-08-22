//
//  QiitaURLQueryParameter.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/17.
//
//

import Foundation

struct QiitaURLQueryParameter {
    let name: String
    let value: String
    
    var toPrameterString: String {
        return "\(name)=\(value)"
    }
    
    private static func stringValue(value: Any) -> String {
        switch value {
        case let value as String: return value
        default: return "\(value)"
        }
    }
    
    private static func encodedValue(value: Any, needsEncode: Bool) -> String? {
        let value = stringValue(value)
        if needsEncode {
            let encodedValue = value.RFC3986Encode
            if encodedValue.isEmpty {
                return nil
            }
            return encodedValue
        }
        return value
    }
    
    init?(name: String, value: Any?, needsEncode: Bool = true) {
        guard
            let value = value,
            let encodedValue = QiitaURLQueryParameter.encodedValue(value, needsEncode: needsEncode)
            else {
                return nil
        }
        self.value = encodedValue
        self.name = name
    }
}
