//
//  JSONHelper.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

typealias JSONFile = String

class JSONHelper {
    class func jsonFileToDict(jsonName: String) -> [String: AnyObject]? {
        if let path = Bundle.tests.path(forResource: jsonName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: AnyObject] {
                    return jsonResult
                }
            } catch {
                return nil
            }
        }
        return nil
    }

    class func jsonFileToData(jsonName: String) -> Data? {
        if let path = Bundle.tests.path(forResource: jsonName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                return try JSONSerialization.data(withJSONObject: json, options: [])
            } catch {
                return nil
            }
        }
        return nil
    }

    class func jsonFileToString(jsonName: String) -> String? {
        if let path = Bundle.tests.path(forResource: jsonName, ofType: "json") {
            do {
                let jsonString = try String(contentsOfFile: path)
                return jsonString
            } catch {
                return nil
            }
        }
        return nil
    }

    class func convertJSONToData(in fileName: String) -> Data? {
        guard let path = Bundle.tests.path(forResource: fileName, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) else {
                return nil
        }

        return jsonData
    }
}
