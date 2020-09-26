//
//  ImageListModel.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

struct ImageListModel: Codable, ImageListable {
    var totalRecords: Int
    var records: [ImageModel]
    
    private enum CodingKeys: String, CodingKey {
        case totalRecords = "totalHits"
        case records = "hits"
    }
}

protocol ImageListable {
    var totalRecords: Int { get }
    var records: [ImageModel] { get set }
}

extension ImageListable {
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

struct ImageModel: Codable, ImageDisplayable {
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
    var id: Int { get }
    var largeImageURL: String { get }
    var previewURL: String { get  }
}


