//
//  QiitaResponse.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/23.
//
//

import Foundation

public enum QiitaResult<T> {
    case Success(T)
    case Failure(NSError)
}

public class QiitaResponse<T> {
    public let result : QiitaResult<T>
    public let httpURLResponse: NSHTTPURLResponse?
    
    public var totalCount: Int? {
        return httpURLResponse?.totalCount
    }
    
    public required init(result: QiitaResult<T>, httpURLResponse: NSHTTPURLResponse?) {
        self.result = result
        self.httpURLResponse = httpURLResponse
    }
}
