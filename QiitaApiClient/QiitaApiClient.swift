//
//  QiitaApiClient.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/17.
//
//

import UIKit

public class QiitaApiClient {
    public static let sharedClient = QiitaApiClient()
    
    private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    private init() {}
    
    private func checkAccessToken(completion: (() -> ())) {
        if let _ = QiitaApplicationInfo.sharedInfo.code {
            completion()
            return
        }
        showAuthorizeViewController() { [weak self] in
            self?.accessToken({
                completion()
            }, failure: nil)
        }
    }
    
    private func showAuthorizeViewController(completion: (() -> ())) {
        var viewController = UIApplication.sharedApplication().keyWindow?.rootViewController
        while let presentingViewController = viewController?.presentingViewController {
            viewController = presentingViewController
        }
        let authorizeVC = QiitaAuthorizeViewController()
        authorizeVC.didFinishClose = completion
        viewController?.presentViewController(authorizeVC, animated: true, completion: nil)
    }
    
    private func httpRequest(request: NSMutableURLRequest, success: ([String : NSObject] -> ())?, failure: (NSError -> ())?) {
        print(request.URL?.absoluteString)
        print(request.allHTTPHeaderFields)
        let task = session.dataTaskWithRequest(request) { [weak self] data, response, error in
            if let error = error {
                failure?(error)
                return
            }
            guard let data = data else {
                return
            }
            guard let response = response as? NSHTTPURLResponse else {
                return
            }
            
            if response.statusCode == 401 {
                dispatch_async(dispatch_get_main_queue()) {
                    self?.showAuthorizeViewController {
                        self?.accessToken({
                            if let accessToken = QiitaApplicationInfo.sharedInfo.accessToken {
                                request.setAccessToken(accessToken)
                            }
                            self?.httpRequest(request, success: success, failure: failure)
                        }, failure: nil)
                    }
                }
                return
            }
            
            do {
                guard let dict = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String : NSObject] else {
                    return
                }
                success?(dict)
            } catch let e as NSError {
                failure?(e)
            }
            
        }
        task.resume()
    }
    
    public func request(method: QiitaHttpMethod, success: ([String : NSObject] -> ())?, failure: (NSError -> ())?) {
        checkAccessToken { [weak self] in
            guard let urlRequest = NSMutableURLRequest(method: method) else { return }
            self?.httpRequest(urlRequest, success: success, failure: failure)
        }
    }
    
    func accessToken(success: (() -> ())?, failure: (NSError -> ())?) {
        let info = QiitaApplicationInfo.sharedInfo
        guard let code = info.code else { return }
        request(.Post(.AccessTokens(clientId: info.clientId, clientSecret: info.clientSecret, code: code)), success: { dict in
            QiitaApplicationInfo.sharedInfo.accessToken = dict["token"] as? String
            success?()
        }, failure: failure)
    }
}
