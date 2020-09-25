//
//  UIAlertAction.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import UIKit

extension UIAlertAction {
    @objc
    class func makeActionWithTitle(title: String?,
                                   style: UIAlertAction.Style,
                                   handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}
