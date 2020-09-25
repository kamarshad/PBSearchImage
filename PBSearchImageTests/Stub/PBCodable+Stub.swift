//
//  PBCodable+Stub.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

@testable import PBSearchImage
import Foundation

class PBCodable: NSObject { }

extension PBCodable {
    static func jsonStub(with fileName: String) -> [String: AnyObject] {
        guard let jsonData = JSONHelper.jsonFileToData(jsonName: fileName),
            let json = try? JSONSerialization.jsonObject(with: jsonData),
            let modelJson = json as? [String: AnyObject] else { return [:] }
        return modelJson
    }
}
