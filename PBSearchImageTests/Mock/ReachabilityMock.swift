//
//  ReachabilityMock.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 09/05/2020.
//  Copyright © 2020 MKS. All rights reserved.
//

@testable import PBSearchImage
import Foundation

class ReachabilityMock: ReachabilityAdapter {
    var currentReachabilityStatus: Reachability.NetworkStatus = .notReachable
}
