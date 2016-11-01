//
//  QiitaPathStringReturnable.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/17.
//
//

import Foundation

protocol QiitaPathStringReturnable {
    var pathString: String { get }
    func convertParametersToString(_ queries: QiitaURLQueryParameter?...) -> String
    func convertParametersToString(_ queries: [QiitaURLQueryParameter?]) -> String
}

extension QiitaPathStringReturnable {
    func convertParametersToString(_ queries: [QiitaURLQueryParameter?]) -> String {
        let queries: [String] = queries.flatMap { $0?.toPrameterString }
        let queryString: String = queries.reduce("") { $0 == "" ? $1 : $0 + "&" + $1 }
        return queryString
    }
    func convertParametersToString(_ queries: QiitaURLQueryParameter?...) -> String {
        return convertParametersToString(queries)
    }
}
