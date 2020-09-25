//
//  UIViewController+Tests.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

@testable import PBSearchImage
import UIKit

extension UIViewController {
    
    func simulateViewLifeCycle(navigationController: UINavigationController = UINavigationController()) {
        //create window
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        navigationController.viewControllers = [self]
        window.rootViewController = navigationController
        //force view life cycle (view will appear)
        beginAppearanceTransition(true, animated: true)
        //viewdidappear
        endAppearanceTransition()
    }
    
}
