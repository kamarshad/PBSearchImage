//
//  NetworkConstantAdapter.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//


import Foundation

protocol NetworkConstantAdapter {
    static var networkPlistFileName: String { get }
    static var networkAdapterKey: String { get }

    static func getEndPoint(for key: String) -> NetworkEndpointModel?
}

extension NetworkConstantAdapter {
    static func getEndPoint(for key: String) -> NetworkEndpointModel? {
        return NetworkEndpointModel(from: networkPlistFileName, adapterKey: networkAdapterKey, endPointKey: key)
    }
}
