//
//  NetworkModel.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

struct APIServerManager: Codable {
    private (set) var info: APIServerInfoModel
    static let shared = APIServerManager()
    
    func createURL(for endPoint: NetworkEndpointModel) -> URL? {
        return URL.createURL(scheme: info.scheme,
                             host: info.host,
                             port: info.port)?.urlByAppending(domain: endPoint.baseURL,
                                                              endpoint: endPoint.path)
    }
    
    private init() {
        info = PropertyListDecoder().decode(APIServerInfoModel.self,
                                            from: NetworkConstants.serverConfigFileName) ?? APIServerInfoModel()
    }
}

struct APIServerInfoModel: Codable {
    let scheme: String
    let host: String
    let port: String?
    
    init() {
        scheme = Constants.emptyString
        host = Constants.emptyString
        port = nil
    }
}

struct NetworkEndpointModel: Decodable {
    let path: String
    let method: PBHTTPMethod
    var baseURL: String = Constants.emptyString
    
    private enum CodingKeys: String, CodingKey {
        case path
        case method
    }
    
    init?(from plist: String, adapterKey: String, endPointKey: String) {
        guard let adapter = NetworkEndpointModel.from(plist: plist, adapterKey: adapterKey),
            let endpointModel = NetworkEndpointModel.from(adapter: adapter, endPointKey: endPointKey) else { return nil }
        baseURL = adapter.baseURL
        path = endpointModel.path
        method = endpointModel.method
    }
    
    private static func from(plist: String, adapterKey: String) -> NetworkAdapterModel? {
        return PropertyListDecoder().decode([String: NetworkAdapterModel].self, from: plist)?[adapterKey]
    }
    
    private static func from(adapter: NetworkAdapterModel, endPointKey: String) -> NetworkEndpointModel? {
        return adapter.endpoints[endPointKey]
    }
}

struct NetworkAdapterModel: Decodable {
    let baseURL: String
    let endpoints: [String: NetworkEndpointModel]
}
