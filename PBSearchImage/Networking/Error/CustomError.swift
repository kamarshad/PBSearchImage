//
//  CustomError.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

class CustomError: NSObject {
    var errorType: CustomErrorType?
    var errorCode: String?
    var errorDescription: String?
    var errorMessage: String
    var title: String

    override var description: String {
        var desc = "Type= \(String(describing: errorType))"
        if let code = errorCode {
            desc.append(", Code= \(code)")
        }
        if let errorDesc = errorDescription {
            desc.append(", Description= \(errorDesc)")
        }
        return desc
    }

    init(type: CustomErrorType) {
        errorType = type
        errorDescription = type.message
        errorMessage = type.message
        title = type.title
    }

    init(error: Error) {
        title = UIStringConstants.errorAlertTitle
        errorMessage = error.localizedDescription
    }
}

