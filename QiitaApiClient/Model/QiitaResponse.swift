//
//  QiitaResponse.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/23.
//
//

import Foundation

public enum QiitaResult<T> {
    case success(T)
    case failure(Error)
}

open class QiitaResponse<T> {
    open let result : QiitaResult<T>
    open let httpURLResponse: HTTPURLResponse?
    
    open var totalCount: Int? {
        return httpURLResponse?.totalCount
    }
    
    init(result: QiitaResult<T>, httpURLResponse: HTTPURLResponse?) {
        self.result = result
        self.httpURLResponse = httpURLResponse
    }
}

public enum QiitaNoDataResult {
    case success
    case failure(Error)
}

open class QiitaNoDataResponse {
    open let result : QiitaNoDataResult
    open let httpURLResponse: HTTPURLResponse?
    
    init(result: QiitaNoDataResult, httpURLResponse: HTTPURLResponse?) {
        self.result = result
        self.httpURLResponse = httpURLResponse
    }
}
