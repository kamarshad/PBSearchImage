//
//  ImageListModel.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

class ImageListModel: Codable {
    var totalRecords: Int
    var records: [ImageModel]
    
    private enum CodingKeys: String, CodingKey {
        case totalRecords = "totalHits"
        case records = "hits"
    }
    
    // MARK: Helper properties
    var fetchedRecords: Int {
        return records.count
    }
    var isNonEmpty: Bool {
        return records.isNonEmpty
    }
    var totalAvailableRecords: Int {
        return totalRecords
    }
}

class ImageModel: Codable, ImageDisplayable {
    var id: Int
    var previewURL: String
    var largeImageURL: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case previewURL
        case largeImageURL
    }
}

protocol ImageDisplayable {
    var largeImageURL: String { get }
    var previewURL: String { get  }
}


