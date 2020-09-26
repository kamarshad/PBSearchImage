//
//  RecentSearchDatabaseAdapterTests.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import PBSearchImage

class RecentSearchDatabaseAdapterTests: QuickSpec {
    var dbAdapter: RecentSearchDatabaseAdapter!
    
    override func spec() {
        describe("RecentSearchDatabaseAdapter UT's") {
            
            context("when getRecentSearchs called") {
                context("and no search was performed earlier") {
                    beforeEach {
                        self.dbAdapter = RecentSearchDatabaseAdapter(with: DatabaseManagerMock())
                    }
                    afterEach {
                        self.dbAdapter = nil
                    }
                    it("should return no recent search") {
                        let recentSearches = self.dbAdapter.getRecentSearchs()
                        expect(recentSearches).to(beNil())
                    }
                }
                context("and few searches were performed earlier") {
                    beforeEach {
                        let persistentStore = DatabaseManagerMock()
                        persistentStore[PersistentKeys.recentSearch] = ["Search 1", "Search 2"]
                        self.dbAdapter = RecentSearchDatabaseAdapter(with: persistentStore)
                    }
                    afterEach {
                        self.dbAdapter = nil
                    }
                    it("should return thoese performed searches") {
                        let recentSearches = self.dbAdapter.getRecentSearchs()
                        expect(recentSearches).toNot(beNil())
                        expect(recentSearches?.isNonEmpty == true) == true
                    }
                }
            }
            
            context("when saveRecentSearch called") {
                context("and no search was performed earlier") {
                    beforeEach {
                        self.dbAdapter = RecentSearchDatabaseAdapter(with: DatabaseManagerMock())
                        self.dbAdapter.saveRecentSearch(Constants.defaultKeyword)
                    }
                    it("should not have more than that") {
                        let recentSearches = self.dbAdapter.getRecentSearchs()
                        expect(recentSearches?.first == Constants.defaultKeyword) == true
                        expect(recentSearches?.count == 1) == true
                    }
                }
                context("and few searches were performed earlier") {
                    beforeEach {
                        let persistentStore = DatabaseManagerMock()
                        persistentStore[PersistentKeys.recentSearch] = ["Search 1", "Search 2"]
                        self.dbAdapter = RecentSearchDatabaseAdapter(with: persistentStore)
                        self.dbAdapter.saveRecentSearch(Constants.defaultKeyword)
                    }
                    it("should return just performed search at first index") {
                        let recentSearches = self.dbAdapter.getRecentSearchs()
                        expect(recentSearches?.first == Constants.defaultKeyword) == true
                        expect(recentSearches?.count == 3) == true
                    }
                }
                context("and when same search is performed") {
                    beforeEach {
                        let persistentStore = DatabaseManagerMock()
                        persistentStore[PersistentKeys.recentSearch] = ["Search 1", Constants.defaultKeyword]
                        self.dbAdapter = RecentSearchDatabaseAdapter(with: persistentStore)
                        self.dbAdapter.saveRecentSearch(Constants.defaultKeyword)
                    }
                    it("should no duplicate entry in persistent store and be updated at first index of recent search") {
                        let recentSearches = self.dbAdapter.getRecentSearchs()
                        expect(recentSearches?.first == Constants.defaultKeyword) == true
                        expect(recentSearches?.count == 2) == true
                    }
                    
                }
            }
        }
    }
}
