//
//  URL+Helper.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//


import Foundation

extension URL {
    static func createURL(scheme: String, host: String, port: String?) -> URL? {
        guard let portVal = port, !portVal.isEmpty else {
            return URL(string: "\(scheme)://\(host)")
        }
        return URL(string: "\(scheme)://\(host):\(portVal)")
    }

    func urlByAppending(domain: String, endpoint: String) -> URL? {
        return appendingPathComponent(domain).appendingPathComponent(endpoint)
    }
}
