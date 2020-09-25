//
//  CustomErrorType.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

enum CustomErrorType: String {
    case notReachable
    case invalidStatus
    case emptyResponse
    case invalidResponseFormat
    case invalidRequestFormat
    case badUrl
    case serverError
    case responseMappingError
    case generalError
    case apiKeyMissing
}
