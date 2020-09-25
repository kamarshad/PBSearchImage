//
//  NetworkClientMock.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 09/05/2020.
//  Copyright © 2020 MKS. All rights reserved.
//

@testable import PBSearchImage
import Foundation

class NetworkClientMock: NetworkClientAdapter {
    var json: Any?
    var error: CustomError?
    
    @discardableResult func sendRequest(withRequestBody requestBody: String?,
                                        requestHeaders: Headers,
                                        queryParameters: QueryParameters,
                                        completionHandler: @escaping CompletionBlock) -> URLSessionTask? {
        completionHandler(json, error)
        return nil
    }
}
