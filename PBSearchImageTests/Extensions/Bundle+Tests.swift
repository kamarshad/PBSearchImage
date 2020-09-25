//
//  Bundle+Tests.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

extension Bundle {
    // This is really useful if we want to use resources from Bundle of PBSearchImage target
    // such as JSONs stubs or images used for unit testing.
    open class var tests: Bundle {
        return Bundle.init(for: TestsConstants.self)
    }
}
