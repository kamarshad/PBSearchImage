//
//  ImageRequestModel+Stub.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//


@testable import PBSearchImage
import Foundation

extension SearchImageQueryModel {
    
    static var defaultQueryModel: SearchImageQueryModel  {
        return SearchImageQueryModel(query: "Apple", pageNo: "1", apiKey: APIConstants.apiKey)
    }
}
