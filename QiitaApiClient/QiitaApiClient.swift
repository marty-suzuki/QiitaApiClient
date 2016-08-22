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
    
    private var authorizeViewControllerAnimating = false
    
    private func checkCode(needAuthenticate: Bool, success: (() -> ())?, failure: (NSError -> ())?) {
        if !needAuthenticate {
            success?()
            return
        }
        if let _ = QiitaApplicationInfo.sharedInfo.code {
            success?()
            return
        }
        showAuthorizeViewController() { [weak self] in
            self?.accessToken(success, failure: failure)
        }
    }
    
    private func topPresentingViewController() -> UIViewController? {
        var viewController = UIApplication.sharedApplication().keyWindow?.rootViewController
        while let presentingViewController = viewController?.presentingViewController {
            viewController = presentingViewController
        }
        return viewController
    }
    
    private func showAuthorizeViewController(completion: (() -> ())) {
        if authorizeViewControllerAnimating {
            completion()
            return
        }
        authorizeViewControllerAnimating = true
        
        let viewController = topPresentingViewController()
        if let vc = viewController as? QiitaAuthorizeViewController {
            completion()
            return
        }
                
        if let vc = viewController {
            let authorizeVC = QiitaAuthorizeViewController()
            authorizeVC.didFinishClose = completion
            vc.presentViewController(authorizeVC, animated: true) {
                self.authorizeViewControllerAnimating = false
            }
            return
        }
        self.authorizeViewControllerAnimating = false
        completion()
    }
    
    private func httpRequest(request: NSMutableURLRequest, success: ((NSHTTPURLResponse, NSData) -> ()), failure: (NSError -> ())?) {
        let task = session.dataTaskWithRequest(request) { [weak self] in
            if let error = $0.2 {
                failure?(error)
                return
            }
            guard
                let data = $0.0,
                let response = $0.1 as? NSHTTPURLResponse
            else {
                failure?(NSError(errorDomain: .InvalidResponseData))
                return
            }
            let statusCode = response.statusCodeType
            switch statusCode {
            case .Unauthorized:
                dispatch_async(dispatch_get_main_queue()) {
                    self?.showAuthorizeViewController { [weak self] in
                        self?.accessToken({ [weak self] in
                            if let accessToken = QiitaApplicationInfo.sharedInfo.accessToken {
                                request.setAccessToken(accessToken)
                            }
                            self?.httpRequest(request, success: success, failure: failure)
                        }, failure: failure)
                    }
                }
                return
            case .BadRequest, .Forbidden, .NotFound, .InternalServerError:
                do {
                    guard
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String : NSObject],
                        let error = NSError(response: response, dictionary: dictionary)
                    else {
                        failure?(NSError(errorDomain: .InvalidErrorData))
                        return
                    }
                    failure?(error)
                } catch let e as NSError {
                    failure?(e)
                }
            case .OK, .Created, .NoContent:
                success(response, data)
            case .Unknown:
                failure?(NSError(errorDomain: .UnknownStatusCode))
            }
        }
        task.resume()
    }
    
    public func request(method: QiitaHttpMethod, success: (() -> ())?, failure: (NSError -> ())?) {
        checkCode(method.needAuthenticate, success: { [weak self] in
            guard let urlRequest = NSMutableURLRequest(method: method) else { return }
            self?.httpRequest(urlRequest, success: { data in
                success?()
            }, failure: failure)
        }, failure: failure)
    }
    
    public func request<T: QiitaModel>(method: QiitaHttpMethod, success: ((NSHTTPURLResponse, T) -> ())?, failure: (NSError -> ())?) {
        checkCode(method.needAuthenticate, success: { [weak self] in
            guard let urlRequest = NSMutableURLRequest(method: method) else { return }
            self?.httpRequest(urlRequest, success: {
                do {
                    guard
                        let dictionary = try NSJSONSerialization.JSONObjectWithData($0.1, options: .AllowFragments) as? [String : NSObject],
                        let model = T(dictionary: dictionary)
                    else {
                        failure?(NSError(errorDomain: .InvalidResponseData))
                        return
                    }
                    success?($0.0, model)
                } catch let e as NSError {
                    failure?(e)
                }
            }, failure: failure)
        }, failure: failure)
    }
    
    public func request<T: QiitaModel>(method: QiitaHttpMethod, success: ((NSHTTPURLResponse, [T]) -> ())?, failure: (NSError -> ())?) {
        checkCode(method.needAuthenticate, success: { [weak self] in
            guard let urlRequest = NSMutableURLRequest(method: method) else { return }
            self?.httpRequest(urlRequest, success: {
                do {
                    guard
                        let array = try NSJSONSerialization.JSONObjectWithData($0.1, options: .AllowFragments) as? [[String : NSObject]]
                    else {
                        failure?(NSError(errorDomain: .InvalidResponseData))
                        return
                    }
                    let models: [T] = array.flatMap({ T(dictionary: $0) })
                    success?($0.0, models)
                } catch let e as NSError {
                    failure?(e)
                }
            }, failure: failure)
        }, failure: failure)
    }
    
    func accessToken(success: (() -> ())?, failure: (NSError -> ())?) {
        let info = QiitaApplicationInfo.sharedInfo
        guard let code = info.code else {
            failure?(NSError(errorDomain: .NotFindCode))
            return
        }
        let setAccessToken: (NSHTTPURLResponse, QiitaAccessToken) -> () = {
            QiitaApplicationInfo.sharedInfo.accessToken = $0.1.token
            success?()
        }
        request(.Post(.AccessTokens(clientId: info.clientId, clientSecret: info.clientSecret, code: code)), success: setAccessToken, failure: failure)
    }
}
