//
//  QiitaApiClient.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/17.
//
//

import UIKit

open class QiitaApiClient {
    //MARK: - Static constant
    open static let `default` = QiitaApiClient()
    
    //MARK: - Properties
    fileprivate let session = URLSession(configuration: .default)
    fileprivate var authorizeViewControllerAnimating = false
    
    //MARK: - Initializer
    fileprivate init() {}
    
    fileprivate func checkCode(_ needAuthenticate: Bool, success: (() -> ())?, failure: ((HTTPURLResponse?, Error) -> ())?) {
        if !needAuthenticate {
            success?()
            return
        }
        if let _ = QiitaApplicationInfo.default.code {
            success?()
            return
        }
        showAuthorizeViewController() { [weak self] in
            self?.accessToken(success, failure: failure)
        }
    }
    
    fileprivate func topPresentingViewController() -> UIViewController? {
        var viewController = UIApplication.shared.keyWindow?.rootViewController
        while let presentingViewController = viewController?.presentingViewController {
            viewController = presentingViewController
        }
        return viewController
    }
    
    fileprivate func showAuthorizeViewController(_ completion: @escaping () -> ()) {
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
            vc.present(authorizeVC, animated: true) {
                self.authorizeViewControllerAnimating = false
            }
            return
        }
        self.authorizeViewControllerAnimating = false
        completion()
    }
    
    fileprivate func httpRequest(_ request: URLRequest, success: @escaping ((HTTPURLResponse, Data) -> ()), failure: ((HTTPURLResponse?, Error) -> ())?) {
        var request = request
        let task = session.dataTask(with: request, completionHandler: { [weak self] in
            guard let response = $0.1 as? HTTPURLResponse else {
                failure?(nil, NSError(errorDomain: .invalidResponseData))
                return
            }
            if let error = $0.2 {
                failure?(response, error)
                return
            }
            guard let data = $0.0 else {
                failure?(response, NSError(errorDomain: .invalidResponseData))
                return
            }
            let statusCode = response.statusCodeType
            switch statusCode {
            case .unauthorized:
                DispatchQueue.main.async {
                    self?.showAuthorizeViewController { [weak self] in
                        self?.accessToken({ [weak self] in
                            if let accessToken = QiitaApplicationInfo.default.accessToken {
                                request.setAccessToken(accessToken)
                            }
                            self?.httpRequest(request, success: success, failure: failure)
                        }, failure: failure)
                    }
                }
                return
            case .badRequest, .forbidden, .notFound, .internalServerError:
                do {
                    guard
                        let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyHashable : Any],
                        let error = NSError(response: response, dictionary: dictionary)
                    else {
                        failure?(response, NSError(errorDomain: .invalidErrorData))
                        return
                    }
                    failure?(response, error)
                } catch let e as NSError {
                    failure?(response, e)
                }
            case .ok, .created, .noContent:
                success(response, data)
            case .unknown:
                failure?(response, NSError(errorDomain: .unknownStatusCode))
            }
        }) 
        task.resume()
    }
    
    //MARK: - Request for no data response
    open func request(_ method: QiitaHttpMethod, success: ((HTTPURLResponse) -> ())?, failure: ((HTTPURLResponse?, Error) -> ())?) {
        checkCode(method.needAuthenticate, success: { [weak self] in
            guard let urlRequest = URLRequest(method: method) else { return }
            self?.httpRequest(urlRequest, success: { success?($0.0) }, failure: failure)
        }, failure: failure)
    }
    
    open func request(_ method: QiitaHttpMethod, completion: ((QiitaNoDataResponse) -> ())?) {
        request(method, success: {
            completion?(QiitaNoDataResponse(result: QiitaNoDataResult.success, httpURLResponse: $0))
        }) {
            completion?(QiitaNoDataResponse(result: QiitaNoDataResult.failure($0.1), httpURLResponse: $0.0))
        }
    }
    
    //MARK: - Request for single response
    open func request<T: QiitaModel>(_ method: QiitaHttpMethod, success: ((HTTPURLResponse, T) -> ())?, failure: ((HTTPURLResponse?, Error) -> ())?) {
        checkCode(method.needAuthenticate, success: { [weak self] in
            guard let urlRequest = URLRequest(method: method) else { return }
            self?.httpRequest(urlRequest, success: {
                do {
                    guard
                        let dictionary = try JSONSerialization.jsonObject(with: $0.1, options: .allowFragments) as? [AnyHashable : Any],
                        let model = T(dictionary: dictionary)
                    else {
                        failure?($0.0, NSError(errorDomain: .invalidResponseData))
                        return
                    }
                    success?($0.0, model)
                } catch let e as NSError {
                    failure?($0.0, e)
                }
            }, failure: failure)
        }, failure: failure)
    }
    
    open func request<T: QiitaModel>(_ method: QiitaHttpMethod, completion: ((QiitaResponse<T>) -> ())?) {
        request(method, success: {
            completion?(QiitaResponse(result: QiitaResult.success($0.1), httpURLResponse: $0.0))
        }) {
            completion?(QiitaResponse(result: QiitaResult.failure($0.1), httpURLResponse: $0.0))
        }
    }
    
    //MARK: - Request for array response
    open func request<T: QiitaModel>(_ method: QiitaHttpMethod, success: ((HTTPURLResponse, [T]) -> ())?, failure: ((HTTPURLResponse?, Error) -> ())?) {
        checkCode(method.needAuthenticate, success: { [weak self] in
            guard let urlRequest = URLRequest(method: method) else { return }
            self?.httpRequest(urlRequest, success: {
                do {
                    guard
                        let array = try JSONSerialization.jsonObject(with: $0.1, options: .allowFragments) as? [[AnyHashable : Any]]
                    else {
                        failure?($0.0, NSError(errorDomain: .invalidResponseData))
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
    
    open func request<T: QiitaModel>(_ method: QiitaHttpMethod, completion: ((QiitaResponse<[T]>) -> ())?) {
        request(method, success: {
            completion?(QiitaResponse(result: QiitaResult.success($0.1), httpURLResponse: $0.0))
        }) {
            completion?(QiitaResponse(result: QiitaResult.failure($0.1), httpURLResponse: $0.0))
        }
    }
    
    //MARK: - Get access token
    func accessToken(_ success: (() -> ())?, failure: ((HTTPURLResponse?, Error) -> ())?) {
        let info = QiitaApplicationInfo.default
        guard let code = info.code else {
            failure?(nil, NSError(errorDomain: .notFindCode))
            return
        }
        let setAccessToken: (HTTPURLResponse, QiitaAccessToken) -> () = {
            QiitaApplicationInfo.default.accessToken = $0.1.token
            success?()
        }
        request(.post(.accessTokens(clientId: info.clientId, clientSecret: info.clientSecret, code: code)), success: setAccessToken, failure: failure)
    }
}
