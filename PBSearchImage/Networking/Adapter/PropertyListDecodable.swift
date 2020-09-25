//
//  PropertyListDecodable.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//


import Foundation

typealias PListFile = String

protocol PropertyListDecodable {
    func decode<T>(_ type: T.Type, from plistFile: PListFile) -> T? where T: Decodable
}
