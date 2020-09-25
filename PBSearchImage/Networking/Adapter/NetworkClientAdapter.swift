//
//  NetworkClientAdapter.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//


import Foundation

protocol NetworkClientAdapter {
    @discardableResult func sendRequest(withRequestBody requestBody: String?,
                                        requestHeaders: Headers,
                                        queryParameters: QueryParameters,
                                        completionHandler: @escaping CompletionBlock) -> URLSessionTask?
}

extension NetworkClientAdapter {
    @discardableResult func sendRequest(withRequestBody requestBody: String? = nil,
                                        requestHeaders: Headers = [:],
                                        queryParameters: QueryParameters = [:],
                                        completionHandler: @escaping CompletionBlock) -> URLSessionTask? {
        return sendRequest(withRequestBody: requestBody,
                           requestHeaders: requestHeaders,
                           queryParameters: queryParameters,
                           completionHandler: completionHandler)
    }
}
