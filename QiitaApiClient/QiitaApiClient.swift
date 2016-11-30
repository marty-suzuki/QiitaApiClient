//
//  QiitaApiClient.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/17.
//
//

import UIKit

public enum Result<T> {
    case success(T)
    case failure(Error)
}

public struct Response<T> {
    public let result: Result<T>
    public let urlResponse: HTTPURLResponse?
    public let urlRequest: URLRequest?
    public let statusCode: StatusCode?
    public let data: Data?
}

public enum StatusCode: Int {
    case unknown = 0
    //success
    case ok = 200
    case created = 201
    case accepted = 203
    case noContent = 204
    //client error
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    //server error
    case internalServerError = 500
}

public enum QiitaAPIClientError: Error {
    case noData
    case invalidURL
    case invalidRange(reason: String)
    case decodeFailed(reason: String)
    case statucCode(StatusCode)
    case invalidAccessToken
    case invalidResponseHeaderField(String)
}

public class QiitaApiClient {
    //MARK: - Static constant
    public static let `default` = QiitaApiClient()
    
    //MARK: - Properties
    fileprivate let session = URLSession(configuration: .default)
    fileprivate var authorizeViewControllerAnimating = false
    
    //MARK: - Initializer
    fileprivate init() {}
    
    //MARK: - New
    public func send<Request: QiitaRequestable>(request: Request, completion: @escaping (Response<Request.ResultType>) -> ()) {
        do {
            try request.validate()
        } catch let error {
            completion(Response(result: .failure(error), urlResponse: nil, urlRequest: nil, statusCode: nil, data: nil))
        }
        guard let url = URL(string: request.urlString()) else {
            completion(Response(result: .failure(QiitaAPIClientError.invalidURL), urlResponse: nil, urlRequest: nil, statusCode: nil, data: nil))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        switch request.httpMethod {
        case .post, .patch:
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: request.parameters, options: .prettyPrinted)
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch let error {
                completion(Response(result: .failure(error), urlResponse: nil, urlRequest: nil, statusCode: nil, data: nil))
                return
            }
        default:
            break
        }
        
        if request.useAccessToken {
            guard let accessToken = QiitaApplicationInfo.default.accessToken else {
                completion(Response(result: .failure(QiitaAPIClientError.invalidAccessToken), urlResponse: nil, urlRequest: nil, statusCode: nil, data: nil))
                return
            }
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let task = session.dataTask(with: urlRequest) { [urlRequest] data, response, error in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            let urlResponse = response as? HTTPURLResponse
            let statusCode = StatusCode(rawValue: urlResponse?.statusCode ?? 0) ?? .unknown
            if let error = error {
                completion(Response(result: .failure(error), urlResponse: urlResponse, urlRequest: urlRequest, statusCode: statusCode, data: data))
                return
            }
            guard let data = data else {
                completion(Response(result: .failure(QiitaAPIClientError.noData), urlResponse: urlResponse, urlRequest: urlRequest, statusCode: statusCode, data: nil))
                return
            }
            switch statusCode.rawValue {
            case StatusCode.ok.rawValue...StatusCode.noContent.rawValue:
                break
                
            case StatusCode.unauthorized.rawValue:
                QiitaApplicationInfo.default.accessToken = nil
                fallthrough
                
            default:
                completion(Response(result: .failure(QiitaAPIClientError.statucCode(statusCode)), urlResponse: urlResponse, urlRequest: urlRequest, statusCode: statusCode, data: data))
                return
            }
            do {
                let decodedResult = try Request.decode(data: data)
                completion(Response(result: .success(decodedResult), urlResponse: urlResponse, urlRequest: urlRequest, statusCode: statusCode, data: data))
                return
            } catch let error {
                completion(Response(result: .failure(error), urlResponse: urlResponse, urlRequest: urlRequest, statusCode: statusCode, data: data))
                return
            }
        }
        task.resume()
    }
    
    //MARK: - Old
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
        let request = QiitaAccessTokensPostRequest(clientId: info.clientId, clientSecret: info.clientSecret, code: code)
        send(request: request) { response in
            switch response.result {
            case .success(let accessToken):
                QiitaApplicationInfo.default.accessToken = accessToken.token
                success?()
            case .failure(let error):
                failure?(response.urlResponse, error)
            }
        }
    }
}
