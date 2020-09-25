//
//  UISwipeGestureRecongnizerMock.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

@testable import PBSearchImage
import UIKit

class UISwipeGestureRecongnizerMock: UISwipeGestureRecognizer {
    var mockTarget: AnyObject?
    var mockAction: Selector?

    var mockDirection: UISwipeGestureRecognizer.Direction?

    override init(target: Any?, action: Selector?) {
        mockTarget = target as AnyObject?
        mockAction = action
        super.init(target: target, action: action)
    }

    func perfomSwipe(with direction: UISwipeGestureRecognizer.Direction) {
        guard let mockAction = mockAction else { return }
        mockDirection = direction
        mockTarget?.perform(mockAction, on: Thread.current, with: self, waitUntilDone: true)
    }

    override var direction: UISwipeGestureRecognizer.Direction {
        get {
            if let mockDirection = mockDirection {
                return mockDirection
            }
            return super.direction
        }
        set {
            mockDirection = newValue
        }
    }
}
