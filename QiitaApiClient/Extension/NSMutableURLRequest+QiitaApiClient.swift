//
//  NSMutableURLRequest+QiitaApiClient.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/19.
//
//

import Foundation

extension NSMutableURLRequest {
    static private let baseURL = "https://qiita.com/api/v2"
    
    convenience init?(method: QiitaHttpMethod) {
        let values: (method: String, path: String, httpBody: NSData?, contentType: String?)
        switch method {
        case .Get(let path):
            values = (method: "GET", path: path.absoluteString, httpBody: nil, contentType: nil)
        case .Post(let path):
            do {
                let httpBody = try NSJSONSerialization.dataWithJSONObject(path.dictionary, options: .PrettyPrinted)
                values = (method: "POST", path: path.pathString, httpBody: httpBody, contentType: "application/json")
            } catch let e as NSError {
                return nil
            }
        case .Delete(let path):
             values = (method: "DELETE", path: path.pathString, httpBody: nil, contentType: nil)
        case .Patch(let path):
            do {
                let httpBody = try NSJSONSerialization.dataWithJSONObject(path.dictionary, options: .PrettyPrinted)
                values = (method: "PATHC", path: path.pathString, httpBody: httpBody, contentType: "application/json")
            } catch let e as NSError {
                return nil
            }
        case .Put(let path):
             values = (method: "PUT", path: path.pathString, httpBody: nil, contentType: nil)
        }
        
        guard let URL = NSURL(string: NSMutableURLRequest.baseURL + values.path) else {
            return nil
        }
        self.init(URL: URL)
        if let accessToken = QiitaApplicationInfo.sharedInfo.accessToken {
            self.setAccessToken(accessToken)
        }
        self.HTTPMethod = values.method
        self.HTTPBody = values.httpBody
        if let contentType = values.contentType {
            self.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
    }
    
    func setAccessToken(accessToken: String?) {
        guard let accessToken = accessToken else { return }
        setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    }
}