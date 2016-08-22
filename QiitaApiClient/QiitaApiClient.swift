//
//  QiitaApiClient.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/17.
//
//

import UIKit

public class QiitaApiClient {
    //MARK: - Static constant
    public static let sharedClient = QiitaApiClient()
    
    //MARK: - Properties
    private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    private var authorizeViewControllerAnimating = false
    
    //MARK: - Initializer
    private init() {}
    
    private func checkCode(needAuthenticate: Bool, success: (() -> ())?, failure: ((NSHTTPURLResponse?, NSError) -> ())?) {
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
        if let _ = viewController as? QiitaAuthorizeViewController {
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
    
    private func httpRequest(request: NSMutableURLRequest, success: ((NSHTTPURLResponse, NSData) -> ()), failure: ((NSHTTPURLResponse?, NSError) -> ())?) {
        let task = session.dataTaskWithRequest(request) { [weak self] in
            guard let response = $0.1 as? NSHTTPURLResponse else {
                failure?(nil, NSError(errorDomain: .InvalidResponseData))
                return
            }
            if let error = $0.2 {
                failure?(response, error)
                return
            }
            guard let data = $0.0 else {
                failure?(response, NSError(errorDomain: .InvalidResponseData))
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
                        failure?(response, NSError(errorDomain: .InvalidErrorData))
                        return
                    }
                    failure?(response, error)
                } catch let e as NSError {
                    failure?(response, e)
                }
            case .OK, .Created, .NoContent:
                success(response, data)
            case .Unknown:
                failure?(response, NSError(errorDomain: .UnknownStatusCode))
            }
        }
        task.resume()
    }
    
    //MARK: - Request for no data response
    public func request(method: QiitaHttpMethod, success: (NSHTTPURLResponse -> ())?, failure: ((NSHTTPURLResponse?, NSError) -> ())?) {
        checkCode(method.needAuthenticate, success: { [weak self] in
            guard let urlRequest = NSMutableURLRequest(method: method) else { return }
            self?.httpRequest(urlRequest, success: { success?($0.0) }, failure: failure)
        }, failure: failure)
    }
    
    public func request(method: QiitaHttpMethod, completion: ((QiitaNoDataResponse) -> ())?) {
        request(method, success: {
            completion?(QiitaNoDataResponse(result: QiitaNoDataResult.Success, httpURLResponse: $0))
        }) {
            completion?(QiitaNoDataResponse(result: QiitaNoDataResult.Failure($0.1), httpURLResponse: $0.0))
        }
    }
    
    //MARK: - Request for single response
    public func request<T: QiitaModel>(method: QiitaHttpMethod, success: ((NSHTTPURLResponse, T) -> ())?, failure: ((NSHTTPURLResponse?, NSError) -> ())?) {
        checkCode(method.needAuthenticate, success: { [weak self] in
            guard let urlRequest = NSMutableURLRequest(method: method) else { return }
            self?.httpRequest(urlRequest, success: {
                do {
                    guard
                        let dictionary = try NSJSONSerialization.JSONObjectWithData($0.1, options: .AllowFragments) as? [String : NSObject],
                        let model = T(dictionary: dictionary)
                    else {
                        failure?($0.0, NSError(errorDomain: .InvalidResponseData))
                        return
                    }
                    success?($0.0, model)
                } catch let e as NSError {
                    failure?($0.0, e)
                }
            }, failure: failure)
        }, failure: failure)
    }
    
    public func request<T: QiitaModel>(method: QiitaHttpMethod, completion: (QiitaResponse<T> -> ())?) {
        request(method, success: {
            completion?(QiitaResponse(result: QiitaResult.Success($0.1), httpURLResponse: $0.0))
        }) {
            completion?(QiitaResponse(result: QiitaResult.Failure($0.1), httpURLResponse: $0.0))
        }
    }
    
    //MARK: - Request for array response
    public func request<T: QiitaModel>(method: QiitaHttpMethod, success: ((NSHTTPURLResponse, [T]) -> ())?, failure: ((NSHTTPURLResponse?, NSError) -> ())?) {
        checkCode(method.needAuthenticate, success: { [weak self] in
            guard let urlRequest = NSMutableURLRequest(method: method) else { return }
            self?.httpRequest(urlRequest, success: {
                do {
                    guard
                        let array = try NSJSONSerialization.JSONObjectWithData($0.1, options: .AllowFragments) as? [[String : NSObject]]
                    else {
                        failure?($0.0, NSError(errorDomain: .InvalidResponseData))
                        return
                    }
                    let models: [T] = array.flatMap({ T(dictionary: $0) })
                    success?($0.0, models)
                } catch let e as NSError {
                    failure?($0.0, e)
                }
            }, failure: failure)
        }, failure: failure)
    }
    
    public func request<T: QiitaModel>(method: QiitaHttpMethod, completion: (QiitaResponse<[T]> -> ())?) {
        request(method, success: {
            completion?(QiitaResponse(result: QiitaResult.Success($0.1), httpURLResponse: $0.0))
        }) {
            completion?(QiitaResponse(result: QiitaResult.Failure($0.1), httpURLResponse: $0.0))
        }
    }
    
    //MARK: - Get access token
    func accessToken(success: (() -> ())?, failure: ((NSHTTPURLResponse?, NSError) -> ())?) {
        let info = QiitaApplicationInfo.sharedInfo
        guard let code = info.code else {
            failure?(nil, NSError(errorDomain: .NotFindCode))
            return
        }
        let setAccessToken: (NSHTTPURLResponse, QiitaAccessToken) -> () = {
            QiitaApplicationInfo.sharedInfo.accessToken = $0.1.token
            success?()
        }
        request(.Post(.AccessTokens(clientId: info.clientId, clientSecret: info.clientSecret, code: code)), success: setAccessToken, failure: failure)
    }
}
