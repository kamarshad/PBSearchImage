//
//  ImageListModel+Stub.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 09/05/2020.
//  Copyright © 2020 MKS. All rights reserved.
//

@testable import PBSearchImage
import Foundation

extension ImageListModel {
    static func jsonStub(with fileName: JSONFile = "searchImageResponse") -> [String: AnyObject] {
        guard let jsonData = JSONHelper.jsonFileToData(jsonName: fileName) else {
            return [:]
        }

        do {
            let parsedData = try JSONSerialization.jsonObject(with: jsonData) as? [String: AnyObject]
            return parsedData!
        } catch {
            return [:]
        }
    }

    static func stub(with fileName: JSONFile = "searchImageResponse") -> ImageListModel? {
        guard let jsonData = JSONHelper.jsonFileToData(jsonName: fileName) else {
            return nil
        }

        do {
            let application = try JSONDecoder().decode(ImageListModel.self, from: jsonData)
            return application
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
