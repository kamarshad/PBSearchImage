//
//  NetworkClient.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

class NetworkClient: NetworkClientAdapter {
    var session: URLSessionAdapter
    var endpoint: NetworkEndpointModel?
    private (set) var reachablity: ReachabilityAdapter?
    private (set) var responseParser: ResponseDataParsable
    private var challengeHandler: URLSessionDelegate?
    private let configuration: URLSessionConfiguration
    
    init(with endpoint: NetworkEndpointModel? = nil,
         responseParser:ResponseDataParsable = JSONResponseParser(),
         reachablity: ReachabilityAdapter? = Reachability(),
         challengeHandler: URLSessionDelegate? = nil) {
        self.reachablity = reachablity
        self.endpoint = endpoint
        self.responseParser = responseParser
        self.challengeHandler = challengeHandler
        configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }
    
    @discardableResult func sendRequest(withRequestBody requestBody: String?,
                                        requestHeaders: Headers,
                                        queryParameters: QueryParameters,
                                        completionHandler: @escaping CompletionBlock) -> URLSessionTask? {
        guard let endpoint = endpoint else {
            completionHandler(nil, CustomError(type: .badUrl))
            return nil
        }
        return handleRequest(endpoint: endpoint,
                             withRequestBody: requestBody,
                             requestHeaders: requestHeaders,
                             queryParameters: queryParameters,
                             completionHandler: completionHandler)
    }
}

private extension NetworkClient {
    
    func handleRequest(endpoint: NetworkEndpointModel,
                       withRequestBody requestBody: String?,
                       requestHeaders: Headers,
                       queryParameters: QueryParameters,
                       completionHandler: @escaping CompletionBlock) -> URLSessionTask? {
        guard reachablity?.currentReachabilityStatus == .reachableViaWiFi ||
            reachablity?.currentReachabilityStatus == .reachableViaWWAN  else {
                completionHandler(nil, CustomError(type: .notReachable))
                return nil
        }
        guard let url = APIServerManager.shared.createURL(for: endpoint),
            let urlRequest = createURLRequest(with: url,
                                              endpoint: endpoint,
                                              requestHeaders: requestHeaders,
                                              queryParameters: queryParameters,
                                              requestBody: requestBody) else {
                                                completionHandler(nil, CustomError(type: .badUrl))
                                                return nil
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let serverError = error {
                    completionHandler(nil, CustomError(error: serverError))
                    return
                }
                self.responseParser.parse(data: data,
                                          response: response,
                                          completionHandler: completionHandler)
            }
        }
        task.resume()
        return task
    }
    
    func createURLRequest(with url: URL,
                          endpoint: NetworkEndpointModel,
                          requestHeaders: Headers,
                          queryParameters: QueryParameters,
                          requestBody: String?) -> URLRequest? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        if !queryParameters.isEmpty {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard  let finalURL = components.url else { return nil }
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = endpoint.method.rawValue
        if let payload = requestBody {
            urlRequest.httpBody =  Data(payload.utf8)
        }
        urlRequest.createRequestHeader(with: requestHeaders)
        return urlRequest
    }
}
