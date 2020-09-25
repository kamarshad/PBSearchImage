//
//  DatabaseManager.swift
//  PBImageApp
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

class UserDefaultsManager: DataBasePersistable {
    private let db: UserDefaults
    
    init() {
        db = UserDefaults.standard
    }
    
    subscript<T>(keyName: PersistentKeys) -> [T]? {
        get {
            return db.value(forKey: keyName.rawValue) as? [T]
        }
        set {
            db.set(newValue, forKey: keyName.rawValue)
            db.synchronize()
        }
    }
}
