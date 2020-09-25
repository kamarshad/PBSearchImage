//
//  DataBasePersistable.swift
//  PBImageApp
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

protocol DataBasePersistable {
    subscript<T>(keyName: PersistentKeys) -> [T]? { get set }
}

enum PersistentKeys: String {
    case recentSearch = "RecentlySearchedKeywords"
}
