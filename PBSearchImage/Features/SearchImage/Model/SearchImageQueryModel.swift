
//
//  SearchImageQueryModel.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

struct SearchImageQueryModel: Codable {
    var query: String
    var pageNo: String
    var apiKey: String
    var perPageRecord: String = "20"
    
    private enum CodingKeys: String, CodingKey {
        case query = "q"
        case pageNo = "page"
        case apiKey = "key"
        case perPageRecord = "per_page"
    }
}
