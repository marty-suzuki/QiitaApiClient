//
//  PathStringReturnable.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/17.
//
//

import Foundation

protocol PathStringReturnable {
    var pathString: String { get }
    func convertParametersToString(queries: QiitaURLQueryParameter?...) -> String
}

extension PathStringReturnable {
    func convertParametersToString(queries: QiitaURLQueryParameter?...) -> String {
        let queries: [String] = queries.flatMap { $0?.toPrameterString }
        let queryString: String = queries.reduce("") { $0 == "" ? $1 : $0 + "&" + $1 }
        return queryString
    }
}