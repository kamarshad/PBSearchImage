//
//  JSONResponseParser.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

class JSONResponseParser: ResponseDataParsable {
    func parse(data: Data?, response: URLResponse?, completionHandler: @escaping CompletionBlock) {
        guard let httpResponse = response as? HTTPURLResponse,
            200 ~= httpResponse.statusCode,
            let responseData = data else {
                completionHandler(nil, CustomError(type: .serverError))
                return
        }
        let serialisedResponse = try? JSONSerialization.jsonObject(with: responseData, options: []) as? JSONDictionary
        guard let json = serialisedResponse else {
            completionHandler(nil, CustomError(type: .invalidResponseFormat))
            return
        }
        completionHandler(json, nil)
    }
}
