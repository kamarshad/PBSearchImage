//
//  ImageListViewModelTests.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 09/05/2020.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import PBSearchImage

class ImageListViewModelTests: QuickSpec {
    var listViewModel: ImageListViewModel!
    var defaultPerPageCount = 20
    
    override func spec() {
        describe("ImageListViewModelTests") {
            beforeEach {
                let mockNetworkClient = NetworkClientMock()
                mockNetworkClient.json = ImageListModel.jsonStub()
                self.listViewModel = ImageListViewModel(networkClient: mockNetworkClient)
            }
            afterEach {
                self.listViewModel = nil
            }
            context("when view model instance initialised") {
                it("should have initialised with default values") {
                    expect(self.listViewModel?.pageNo == 1) == true
                    expect(self.listViewModel?.isFetchRecordInProgress == false) == true
                    expect(self.listViewModel?.imageList == nil) == true
                    expect(self.listViewModel?.imageListData.value.isEmpty) == true
                    expect(self.listViewModel?.canLoadMoreRecords) == true
                }
            }
            
            context("when get images called and received success response") {
                beforeEach {
                    self.listViewModel.getImages(keyword: "apple")
                }
                it("should local data source filled with model") {
                    expect(self.listViewModel.imageListData.value.isNonEmpty) == true
                    expect(self.listViewModel.imageList != nil) == true
                }
            }
            
            context("when more records available at server") {
                beforeEach {
                    self.listViewModel.getImages(keyword: "apple")
                }
                it("should user allowed to go ahead with get more records") {
                    expect(self.listViewModel.canLoadMoreRecords) == true
                }
                it("should fetched recoreds equal to per page recored") {
                    expect(self.listViewModel.fetchedRecords == self.defaultPerPageCount) == true
                }
                context("and when user try to fetch more images") {
                    it("should user allowed to go ahead with get more records") {
                        expect(self.listViewModel.canLoadMoreRecords) == true
                    }
                    it("should double up the fetchedRecords records") {
                        self.listViewModel.getMoreImages(keyword: "apple")
                        expect(self.listViewModel.fetchedRecords == self.defaultPerPageCount*2) == true
                    }
                }
            }
            context("when user try to fetch more images but server does not have any new records") {
                beforeEach {
                    let mockNetworkClient = NetworkClientMock()
                    mockNetworkClient.json = ImageListModel.jsonStub(with: "searchImageResponse1")
                    self.listViewModel = ImageListViewModel(networkClient: mockNetworkClient)
                    self.listViewModel.getImages(keyword: "apple")
                }
                it("should user not allowed to go ahead with get more records") {
                    expect(self.listViewModel.canLoadMoreRecords) == false
                }
            }
            context("when user try to fetch images but server return error") {
                beforeEach {
                    let mockNetworkClient = NetworkClientMock()
                    mockNetworkClient.error = CustomError(type: .serverError)
                    self.listViewModel = ImageListViewModel(networkClient: mockNetworkClient)
                    
                }
                it("should return the error") {
                    waitUntil { done in
                        self.listViewModel.onError = { error in
                            expect(error?.errorType == .serverError) == true
                            done()
                        }
                        self.listViewModel.getImages(keyword: "apple")
                    }
                }
            }
        }
    }
}
