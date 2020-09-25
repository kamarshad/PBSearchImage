//
//  NetworkConstants.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//


import Foundation

// Considering the timeline kept it here.
// Ideally we should keep them in enviornment based configuration.

struct NetworkConstants {
    static let serverConfigFileName = "PBServerConfig"
}

typealias CompletionBlock = (_ response: Any?, _ error: CustomError?) -> Void
typealias DownloadImageBlock = (_ urlString: String?, _ error: CustomError?) -> Void
typealias JSONDictionary = [AnyHashable: Any]
typealias Headers = [String: Any]
typealias QueryParameters = [String: String]

// We can further add the method here. PBAPIEndpointConfig should define the method accordingly.

enum PBHTTPMethod: String, Codable {
    case GET
}
