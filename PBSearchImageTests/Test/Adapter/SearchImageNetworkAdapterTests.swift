//
//  SearchImageNetworkAdapterTests.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 09/05/2020.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import PBSearchImage

class SearchImageNetworkAdapterTests: QuickSpec {
    var networkAdapter: SearchImageNetworkAdapter!
    var queryModel: ImageListRequestModel!
    
    override func spec() {
        describe("SearchImageNetworkAdapterTests") {
            beforeEach {
                self.queryModel = ImageListRequestModel.defaultQueryModel
                let mocknetwork = NetworkClientMock()
                mocknetwork.json = ImageListModel.jsonStub()
                self.networkAdapter = SearchImageNetworkAdapter(networkClient: mocknetwork)
            }
            afterEach {
                self.networkAdapter = nil
            }
            context("when valid query request model is passed") {
                it("should return response model") {
                    self.networkAdapter.fetchImages(with: self.queryModel) { model, error in
                        expect(error).to(beNil())
                        expect(model).toNot(beNil())
                    }
                }
                
            }
            context("when invalid or NIL query request model is passed") {
                it("should return error instead") {
                    self.networkAdapter.fetchImages(with: nil) { model, error in
                        expect(error).toNot(beNil())
                        expect(model).to(beNil())
                    }
                }
            }
            
            context("when error occurred during the api call") {
                beforeEach {
                    let mocknetwork = NetworkClientMock()
                    mocknetwork.error = CustomError(type: .generalError)
                    self.networkAdapter = SearchImageNetworkAdapter(networkClient: mocknetwork)
                }
                afterEach {
                    self.networkAdapter = nil
                }
                it("should return error and model be nil") {
                    self.networkAdapter.fetchImages(with: self.queryModel) { model, error in
                        expect(error).toNot(beNil())
                        expect(error?.errorType == .generalError) == true
                        expect(model).to(beNil())
                    }
                }
            }
            context("when api returns unexpected response") {
                beforeEach {
                    let mocknetwork = NetworkClientMock()
                    mocknetwork.json = [:]
                    self.networkAdapter = SearchImageNetworkAdapter(networkClient: mocknetwork)
                }
                afterEach {
                    self.networkAdapter = nil
                }
                it("should return error and model be nil") {
                    self.networkAdapter.fetchImages(with: self.queryModel) { model, error in
                        expect(error).toNot(beNil())
                        expect(error?.errorType == .responseMappingError) == true
                        expect(model).to(beNil())
                    }
                }
            }
        }
    }
}
