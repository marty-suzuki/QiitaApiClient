//
//  String+RFC3986Encode.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/22.
//
//

import Foundation

extension String {
    var RFC3986Encode: String {
        let allowedCharacterSet: NSMutableCharacterSet = .alphanumericCharacterSet()
        allowedCharacterSet.addCharactersInString("-._~")
        return stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? ""
    }
}
