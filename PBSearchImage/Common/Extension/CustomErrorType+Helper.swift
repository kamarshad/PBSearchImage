//
//  CustomErrorType.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

extension CustomErrorType {
    
    var title: String {
        return UIStringConstants.errorAlertTitle
    }
    
    var message: String {
        switch self {
        case .notReachable:
            return UIStringConstants.noNetworkConnection
        case .invalidStatus:
            return UIStringConstants.invalidStatus
        case .emptyResponse:
            return UIStringConstants.emptyResponse
        case .invalidResponseFormat:
            return UIStringConstants.invalidResponseFormat
        case .invalidRequestFormat:
            return UIStringConstants.invalidRequestFormat
        case .badUrl:
            return UIStringConstants.badURL
        case .serverError:
            return UIStringConstants.serverError
        case .responseMappingError:
            return UIStringConstants.responseMappingError
        case .apiKeyMissing:
            return UIStringConstants.apiKeyMissing
        default:
            return UIStringConstants.generalMessage
        }
    }
}
