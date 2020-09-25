//
//  UIAlertController.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func show(title: String?,
                    message: String?,
                    okButtonText: String? = nil,
                    cancelButtonText: String? = nil,
                    action: UIAlertAction.Type = UIAlertAction.self,
                    from controller: UIViewController,
                    okButtonTapped: (() -> Void)?, cancelButtonTapped: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let handler = cancelButtonTapped, let buttonText = cancelButtonText {
            let actionCancel = action.makeActionWithTitle(title: buttonText, style: .default) { _ in
                handler()
            }
            alertController.addAction(actionCancel)
        } else if let buttonText = cancelButtonText {
            alertController.addAction(UIAlertAction(title: buttonText,
                                                    style: UIAlertAction.Style.default, handler: nil))
        }
        
        if let handler = okButtonTapped {
            let actionOk = action.makeActionWithTitle(title: okButtonText, style: .default) { _ in
                handler()
            }
            alertController.addAction(actionOk)
        } else {
            alertController.addAction(UIAlertAction(title: okButtonText,
                                                    style: UIAlertAction.Style.default, handler: nil))
        }
        
        controller.present(alertController, animated: true, completion: nil)
    }
}
