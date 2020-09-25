//
//  ImageRequestModel+Stub.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//


@testable import PBSearchImage
import Foundation

extension ImageListRequestModel {
    
    static var defaultQueryModel: ImageListRequestModel  {
        return ImageListRequestModel(query: "Apple", pageNo: "1", apiKey: APIConstant.apiKey)
    }
}