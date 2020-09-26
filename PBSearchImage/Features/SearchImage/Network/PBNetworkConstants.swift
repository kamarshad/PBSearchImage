//
//  PBNetworkConstants.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

struct PBNetworkConstants: NetworkConstantAdapter {
    static let networkPlistFileName = "PBAPIEndpointConfig"
    static let networkAdapterKey = "endpointConfig"

    static let kSearchImage = getEndPoint(for: "searchImage")

}
