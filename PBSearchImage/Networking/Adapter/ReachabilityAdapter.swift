//
//  ReachabilityAdapter.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

protocol ReachabilityAdapter {
    var currentReachabilityStatus: Reachability.NetworkStatus { get }
}

extension Reachability: ReachabilityAdapter { }
