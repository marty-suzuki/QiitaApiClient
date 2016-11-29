//
//  NSMutableURLRequest+QiitaApiClient.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

extension URLRequest {
    private struct Const {
        static let baseURL = "https://qiita.com/api/v2"
    }
    
    init?(method: QiitaHttpMethod) {
        let values: (method: String, path: String, httpBody: Data?, contentType: String?)
        switch method {
        case .get(let path):
            values = (method: "GET", path: path.absoluteString, httpBody: nil, contentType: nil)
        case .post(let path):
            do {
                let httpBody = try JSONSerialization.data(withJSONObject: path.dictionary, options: .prettyPrinted)
                values = (method: "POST", path: path.pathString, httpBody: httpBody, contentType: "application/json")
            } catch let e as NSError {
                return nil
            }
        }
        
        guard let URL = URL(string: Const.baseURL + values.path) else {
            return nil
        }
        self.init(url: URL)
        if let accessToken = QiitaApplicationInfo.default.accessToken {
            self.setAccessToken(accessToken)
        }
        self.httpMethod = values.method
        self.httpBody = values.httpBody
        if let contentType = values.contentType {
            self.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
    }
    
    mutating func setAccessToken(_ accessToken: String?) {
        guard let accessToken = accessToken else { return }
        setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    }
}
