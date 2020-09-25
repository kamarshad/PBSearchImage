//
//  UIViewController+Helper.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertMessage(_ error: CustomError?,
                          showTitle: Bool = true,
                          action: UIAlertAction.Type = UIAlertAction.self,
                          okButtonText: String? = UIStringConstants.ok,
                          okButtonTapCompletionHander: (() -> Void)? = nil) {
        if let error = error {
            let title = showTitle ? error.title : Constants.emptyString
            showAlertMessage(title,
                             message: error.errorMessage,
                             okButtonText: okButtonText,
                             action: action,
                             okButtonTapCompletionHander: okButtonTapCompletionHander)
        } else {
            showAlertMessage()
        }
    }
    
    func showAlertMessage(_ title: String? = UIStringConstants.generalAlertTitle,
                          message: String? = UIStringConstants.generalMessage,
                          okButtonText: String? = UIStringConstants.ok,
                          cancelButtonText: String? = nil,
                          action: UIAlertAction.Type = UIAlertAction.self,
                          okButtonTapCompletionHander: (() -> Void)? = nil,
                          cancelButtonTapped: (() -> Void)? = nil) {
        UIAlertController.show(title: title,
                               message: message,
                               okButtonText: okButtonText,
                               cancelButtonText: cancelButtonText,
                               action: action,
                               from: self,
                               okButtonTapped: okButtonTapCompletionHander,
                               cancelButtonTapped: cancelButtonTapped)
    }
    
    
}
