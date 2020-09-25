//
//  PropertyListDecoder.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

private let fileExtension =  "plist"

extension PropertyListDecoder: PropertyListDecodable {
    func decode<T>(_ type: T.Type, from plistFile: PListFile) -> T? where T: Decodable {
        guard let plistFileURL = Bundle.main.url(forResource: plistFile, withExtension: fileExtension),
            let plistData = try? Data(contentsOf: plistFileURL) else { return nil }
        return try? decode(T.self, from: plistData)
    }
}
