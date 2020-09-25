//
//  URLRequest+.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//


import Foundation

extension URLRequest {
    mutating func createRequestHeader(with headers: Headers) {
        headers.forEach { key, value in
            if let value = value as? String {
                setValue(value, forHTTPHeaderField: key)
            }
        }
    }
}
