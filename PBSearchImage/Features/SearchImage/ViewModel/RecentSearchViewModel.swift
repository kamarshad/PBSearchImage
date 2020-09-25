//
//  RecentSearchViewModel.swift
//  PBImageApp
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

class RecentSearchViewModel {
    private let dbAdapter: RecentSearchDatabaseAdapter

    init(databasePeristable: DataBasePersistable) {
        self.dbAdapter = RecentSearchDatabaseAdapter(with: databasePeristable)
    }
    
    var recentSearches: [String] {
        return dbAdapter.getRecentSearchs() ?? []
    }
    
    func saveSearch(_ searchKeyword: String) {
        dbAdapter.saveRecentSearch(searchKeyword)
    }
}
