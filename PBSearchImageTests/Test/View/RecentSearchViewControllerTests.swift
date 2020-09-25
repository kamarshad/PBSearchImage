//
//  RecentSearchViewControllerTests.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import PBSearchImage

class RecentSearchViewControllerTests: QuickSpec {
    var recentSearchVC: RecentSearchViewController!
    
    override func spec() {
        describe("RecentSearchViewController UT's") {
            context("when view loaded and no search performed by user") {
                beforeEach {
                    self.recentSearchVC = RecentSearchViewController.stub()
                }
                afterEach {
                    self.recentSearchVC = nil
                }
                it("should have initialised all IBOutlets") {
                    expect(self.recentSearchVC.tableView).notTo(beNil())
                }
                it("should have empty recentSearches if no search performed") {
                    expect(self.recentSearchVC.recentSearches.isEmpty) == true
                }
                it("should confirms to tableview view data source and delegate protocols") {
                    expect(self.recentSearchVC.tableView.dataSource!.conforms(to: UITableViewDataSource.self)).to(beTrue())
                    expect(self.recentSearchVC.tableView.dataSource!.conforms(to: UITableViewDelegate.self)).to(beTrue())
                    expect(self.recentSearchVC.tableView.dataSource!.responds(to: #selector(self.recentSearchVC.tableView.dataSource?.tableView(_:numberOfRowsInSection:)))).to(beTrue())
                    expect(self.recentSearchVC.tableView.dataSource!.responds(to: #selector(self.recentSearchVC.tableView.dataSource?.tableView(_:cellForRowAt:)))).to(beTrue())
                }
            }
            context("when view loaded and few searches performed by user") {
                beforeEach {
                    let persistentStore = UserDefaultsManagerMock()
                    persistentStore[PersistentKeys.recentSearch] = ["Recent Search 1", "Recent Search 2"]
                    self.recentSearchVC = RecentSearchViewController.stub(with: persistentStore)
                }
                afterEach {
                    self.recentSearchVC = nil
                }
                it("should have non empty recentSearches array if no search performed") {
                    expect(self.recentSearchVC.recentSearches.isNonEmpty) == true
                }
            }
            context("when user select any of the recent search from list") {
                beforeEach {
                    let persistentStore = UserDefaultsManagerMock()
                    persistentStore[PersistentKeys.recentSearch] = ["Recent Search 1", "Recent Search 2"]
                    self.recentSearchVC = RecentSearchViewController.stub(with: persistentStore)
                }
                afterEach {
                    self.recentSearchVC = nil
                }
                it("should return the selected recent search") {
                    self.recentSearchVC.reloadRecentSearches()
                    let indexPath = IndexPath(row: 1, section: 0)
                    self.recentSearchVC.recentSearchCompletion = { recentSearch in
                        expect(recentSearch == "Recent Search 2") == true
                    }
                    self.recentSearchVC.tableView(self.recentSearchVC.tableView, didSelectRowAt: indexPath)
                }
            }
        }
    }
}
