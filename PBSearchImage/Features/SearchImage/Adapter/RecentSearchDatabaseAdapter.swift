//
//  RecentSearchDatabaseAdapter.swift
//  PBImageApp
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

class RecentSearchDatabaseAdapter {
    private var dbManager: DataBasePersistable
    private let maxSearchResult: Int
    
    init(with dbManager: DataBasePersistable, maxSearchResult: Int = 10) {
        self.dbManager = dbManager
        self.maxSearchResult = maxSearchResult
    }
    
    func getRecentSearchs() -> [String]? {
        guard let recentSearches: [String] = dbManager[PersistentKeys.recentSearch] else {  return nil }
        return Array(NSOrderedSet(array: recentSearches)) as? [String]
    }
    
    func saveRecentSearch(_ recentSearch: String) {
        var recentSearches: [String] = getRecentSearchs() ?? []
        recentSearches.insert(recentSearch, at: 0)
        let updatedRecentSearch = Array(NSOrderedSet(array: recentSearches)) as? [String]
        dbManager[PersistentKeys.recentSearch] = updatedRecentSearch
    }
}
