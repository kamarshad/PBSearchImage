//
//  ImageListModelTests.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 09/05/2020.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import PBSearchImage

class ImageListModelTests: QuickSpec {
    var listModel: ImageListModel!
    
    override func spec() {
        describe("ImageListModelTests") {
            context("when model instantiate with default JSON") {
                beforeEach {
                    self.listModel = ImageListModel.stub()
                }
                afterEach {
                    self.listModel = nil
                }
                
                it("should have initialised along with its properties") {
                    expect(self.listModel).notTo(beNil())
                    expect(self.listModel.totalAvailableRecords > 0 ) == true
                    expect(self.listModel.fetchedRecords > 0 ) == true
                    expect(self.listModel.isNonEmpty) == true
                }
               
            }
        }
    }
}
