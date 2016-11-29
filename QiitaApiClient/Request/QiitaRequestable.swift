//
//  QiitaRequestable.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/11/28.
//
//

import Foundation

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

public protocol QiitaRequestable {
    associatedtype ResultType
    associatedtype DecodedJsonType
    
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [String : Any] { get }
    var httpMethod: HttpMethod { get }
    var useAccessToken: Bool { get }
    
    func parametersString() -> String
    func urlString() -> String
    func validate() throws
    
    static func decode(data: Data) throws -> ResultType
    static func jsonDecode(data: Data) throws -> DecodedJsonType
}

extension QiitaRequestable {
    public var baseUrl: String {
        return "https://qiita.com/api/v2"
    }
    
    public func parametersString() -> String {
        return parameters.reduce("") { (result, parameter) in
            (result.isEmpty ? "?" : result + "&") + parameter.key + "=" + String(describing: parameter.value)
        }.RFC3986Encode
    }
    
    public func urlString() -> String {
        let urlString = baseUrl + path
        switch httpMethod {
        case .post, .patch:
            return urlString
        default:
            return urlString + parametersString()
        }
    }
    
    public static func jsonDecode(data: Data) throws -> DecodedJsonType {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        guard let decodedResult = jsonObject as? DecodedJsonType else {
            throw QiitaAPIClientError.decodeFailed(reason: "not matched to \(String(describing: DecodedJsonType.self))")
        }
        return decodedResult
    }
}

extension QiitaRequestable where ResultType == Void, DecodedJsonType == Void {
    public static func decode(data: Data) throws -> ResultType {}
}
