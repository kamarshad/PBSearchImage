//
//  SearchImageViewController.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import PBSearchImage

class SearchImageViewControllerTests: QuickSpec {
    var searchImageVC: SearchImageViewController!
    var defaultResult = 20
    
    override func spec() {
        describe("SearchImageViewController UT's") {
            beforeEach {
                self.searchImageVC = SearchImageViewController.stub()
            }
            afterEach {
                self.searchImageVC = nil
            }
            
            context("when view loaded") {
                it("should have initialised all IBOutlets") {
                    expect(self.searchImageVC?.collectionView).notTo(beNil())
                    expect(self.searchImageVC?.searchBar).notTo(beNil())
                }
                
                it("should have no default keyword in search bar") {
                    expect(self.searchImageVC?.searchBar?.text == .some(Constants.defaultKeyword)) == false
                }
                it("should have collection view loaded with fetched records") {
                    expect(self.searchImageVC.collectionView.numberOfItems(inSection: 0) == self.searchImageVC.viewModel.numberOfItems).toEventually(beTrue(), timeout: TestsConstants.DefaultTimeout)
                }
                it("should confirms to collection view data source protocol") {
                    expect(self.searchImageVC.collectionView.dataSource!.conforms(to: UICollectionViewDataSource.self)).to(beTrue())
                    expect(self.searchImageVC.collectionView.dataSource!.responds(to: #selector(self.searchImageVC.collectionView.dataSource?.collectionView(_:numberOfItemsInSection:)))).to(beTrue())
                    expect(self.searchImageVC.collectionView.dataSource!.responds(to: #selector(self.searchImageVC.collectionView.dataSource?.collectionView(_:cellForItemAt:)))).to(beTrue())
                }
            }
            
            context("when user reaches to bottom of list") {
                beforeEach {
                    self.searchImageVC.fetchImages(Constants.defaultKeyword)
                    let lastItemRowNo = self.searchImageVC.viewModel.fetchedRecords
                    let indexPath = IndexPath(item: lastItemRowNo, section: 0)
                    let cell = self.searchImageVC.collectionView.dequeueReusableCell(withReuseIdentifier: LoadMoreRecordCollectionViewCell.identifier,
                                                                                     for: indexPath)
                    self.searchImageVC.collectionView.dataSource?.collectionView(self.searchImageVC.collectionView, cellForItemAt: indexPath)
                    self.searchImageVC.collectionView.delegate?.collectionView?(self.searchImageVC.collectionView,
                                                                                willDisplay: cell, forItemAt: indexPath)
                    
                }
                it("should trigger load more images") {
                    expect(self.searchImageVC.viewModel.pageNo > 1).toEventually(beTrue(),
                                                                                 timeout: TestsConstants.DefaultTimeout)
                    expect(self.searchImageVC.viewModel.fetchedRecords >= self.defaultResult).toEventually(beTrue(),
                                                                                                           timeout: TestsConstants.DefaultTimeout)
                }
                context("and when search bar was empty") {
                    beforeEach {
                        self.searchImageVC.searchBar.text = Constants.emptyString
                        let lastItemRowNo = self.searchImageVC.viewModel.fetchedRecords
                        let indexPath = IndexPath(item: lastItemRowNo, section: 0)
                        let cell = self.searchImageVC.collectionView.dequeueReusableCell(withReuseIdentifier: LoadMoreRecordCollectionViewCell.identifier,
                                                                                         for: indexPath)
                        self.searchImageVC.collectionView.dataSource?.collectionView(self.searchImageVC.collectionView, cellForItemAt: indexPath)
                        self.searchImageVC.collectionView.delegate?.collectionView?(self.searchImageVC.collectionView,
                                                                                    willDisplay: cell, forItemAt: indexPath)
                    }
                    it("should not trigger load more images") {
                        expect(self.searchImageVC.viewModel.pageNo == 2).toEventually(beTrue(),
                                                                                      timeout: TestsConstants.DefaultTimeout)
                    }
                }
            }
            context("when only one page content is available at server") {
                beforeEach {
                    self.searchImageVC = SearchImageViewController.stub(with: "searchImageResponse1")
                }
                afterEach {
                    self.searchImageVC = nil
                }
                context("and user reaches to bottom of list") {
                    beforeEach {
                        self.searchImageVC.fetchImages(Constants.defaultKeyword)
                        let lastItemRowNo = self.searchImageVC.viewModel.fetchedRecords - 1
                        let indexPath = IndexPath(item: lastItemRowNo, section: 0)
                        self.searchImageVC.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
                    }
                    it("should not trigger load more images") {
                        expect(self.searchImageVC.viewModel.pageNo == 1).toEventually(beTrue(),
                                                                                      timeout: TestsConstants.DefaultTimeout)
                        expect(self.searchImageVC.viewModel.fetchedRecords == self.defaultResult).toEventually(beTrue(),
                                                                                                               timeout: TestsConstants.DefaultTimeout)
                    }
                }
            }
            context("when user taps on any list item") {
                beforeEach {
                    let indexPath = IndexPath(item: 2, section: 0)
                    self.searchImageVC.collectionView.delegate?.collectionView?(self.searchImageVC.collectionView, didSelectItemAt: indexPath)
                }
                it("should push to detail view controller") {
                    expect(self.searchImageVC.navigationController?.topViewController?.isKind(of: DetailViewController.self)).toEventuallyNot(beNil(), timeout: TestsConstants.DefaultTimeoutNavigation)
                }
            }
            context("when user types in searchbar") {
                context("and entered keyword is greater than the maximum input") {
                    it("should not let type that value") {
                        let currentText = "KXQIKBGZSK VLINYYKUPJ IIQPXFBVWT CADVMORILI  MQRZFSZHFM EFQOABZIJW VICXNYODBR IDIQHDPYJK IDIQHDPYJKH"
                        self.searchImageVC.searchBar.text = currentText
                        let range = NSRange(location: currentText.count, length: 0)
                        let expectedResult = self.searchImageVC.searchBar.delegate?.searchBar?(self.searchImageVC.searchBar,
                                                                                               shouldChangeTextIn: range, replacementText: "A")
                        expect(expectedResult) == false
                    }
                }
                context("and entered keyword is less than the maximum input") {
                    it("should let type that value") {
                        let currentText = "KXQIKBGZSK VLINYYKUPJ IIQPXFBVWT CADVMORILI  MQRZFSZHFM EFQOABZIJW VICXNYODBR IDIQHDPYJK"
                        self.searchImageVC.searchBar.text = currentText
                        let range = NSRange(location: currentText.count, length: 0)
                        let expectedResult = self.searchImageVC.searchBar.delegate?.searchBar?(self.searchImageVC.searchBar,
                                                                                               shouldChangeTextIn: range, replacementText: "IDIQHDPYJKH")
                        expect(expectedResult) == true
                    }
                }
                context("and enetered valid length keyword and tap on search button of keyboard") {
                    it("should trigger the search") {
                        let currentText = Constants.defaultKeyword
                        self.searchImageVC.searchBar.text = currentText
                        let range = NSRange(location: currentText.count, length: 0)
                        let expectedResult = self.searchImageVC.searchBar.delegate?.searchBar?(self.searchImageVC.searchBar,
                                                                                               shouldChangeTextIn: range, replacementText: Constants.lineTermination)
                        expect(expectedResult) == true
                        expect(self.searchImageVC.viewModel.pageNo>0) == true
                    }
                }
            }
            context("when user tap in searchbar") {
                context("and if there were few searches earlier performed by user") {
                    beforeEach {
                        let currentText = Constants.defaultKeyword
                        self.searchImageVC.searchBar.text = currentText
                        let persistentStore = UserDefaultsManagerMock()
                        persistentStore[PersistentKeys.recentSearch] = [Constants.defaultKeyword, "Recent Search 2"]
                        self.searchImageVC.recentSearchViewModel = RecentSearchViewModel(databasePeristable: persistentStore)
                        _ = self.searchImageVC.searchBar.delegate?.searchBarShouldBeginEditing?(self.searchImageVC.searchBar)
                    }
                    it("should have recent search view controller as child view controller") {
                        expect(self.searchImageVC.children.isNonEmpty) == true
                    }
                }
                context("and if there were searches performed by user") {
                    context("and user select any of the listed recent searches") {
                        beforeEach {
                            let currentText = Constants.defaultKeyword
                            self.searchImageVC.searchBar.text = currentText
                            let persistentStore = UserDefaultsManagerMock()
                            persistentStore[PersistentKeys.recentSearch] = ["Recent Search 1", "Recent Search 2"]
                            let recentSearchViewModel = RecentSearchViewModel(databasePeristable: persistentStore)
                            self.searchImageVC.recentSearchViewModel = recentSearchViewModel
                            _ = self.searchImageVC.searchBar.delegate?.searchBarShouldBeginEditing?(self.searchImageVC.searchBar)
                            let recentSearchVC = self.searchImageVC.children.first as? RecentSearchViewController
                            recentSearchVC?.viewModel = recentSearchViewModel
                            recentSearchVC?.reloadRecentSearches()
                            recentSearchVC?.tableView(recentSearchVC!.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        }
                        it("should remove the recent search view controller from search image screen") {
                            expect(self.searchImageVC.children.isEmpty) == true
                        }
                    }
                }
                
                context("and if there was no search performed by user") {
                    beforeEach {
                        let currentText = Constants.defaultKeyword
                        self.searchImageVC.searchBar.text = currentText
                        _ = self.searchImageVC.searchBar.delegate?.searchBarShouldBeginEditing?(self.searchImageVC.searchBar)
                    }
                    it("should have recent search view controller as child view controller") {
                        expect(self.searchImageVC.children.isEmpty) == true
                    }
                    
                }
                context("and user dragges the collection view") {
                    beforeEach {
                        self.searchImageVC.scrollViewDidEndDragging(UIScrollView(), willDecelerate: true)
                    }
                    it("should recent search view controller removed from search result") {
                        expect(self.searchImageVC.children.isEmpty) == true
                    }
                }
            }
        }
    }
}

