//
//  UserDefaultsManagerMock.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

@testable import PBSearchImage
import Foundation

class UserDefaultsManagerMock: DataBasePersistable {
    private var peristentStore: [String: Any] = [:]

    subscript<T>(keyName: PersistentKeys) -> [T]? {
        get {
            return peristentStore[keyName.rawValue] as? [T]
        }
        set(newValue) {
            peristentStore[keyName.rawValue] = newValue
        }
    }
}
