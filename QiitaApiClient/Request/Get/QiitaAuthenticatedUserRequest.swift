//
//  QiitaAuthenticatedUserRequest.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/11/28.
//
//

import Foundation

struct QiitaAuthenticatedUserRequest: QiitaGetRequestable {
    
    typealias ResultType = QiitaAuthenticatedUser
    typealias DecodedJsonType = [AnyHashable : Any]
    
    let path: String = "/authenticated_user"
    let parameters: [String : Any] = [:]
    let useAccessToken: Bool = true
    
    func validate() throws {}
    
    static func decode(data: Data) throws -> ResultType {
        let decodedJson = try jsonDecode(data: data)
        guard let user = QiitaAuthenticatedUser(dictionary: decodedJson) else {
            throw QiitaAPIClientError.decodeFailed(reason: "can not convert to QiitaAuthenticatedUser")
        }
        return user
    }
}
