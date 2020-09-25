//
//  DetailViewControllerTests.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 09/05/2020.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import PBSearchImage

class DetailViewControllerTests: QuickSpec {
    var detailVC: DetailViewController!
    var searchedImages: [ImageDisplayable] = []
    
    override func spec() {
        describe("DetailViewControllerTests") {
            beforeEach {
                self.searchedImages = ImageListModel.stub()?.records ?? []
                self.detailVC = DetailViewController.stub(with: self.searchedImages, selectedImageIndex: 0)
                
            }
            afterEach {
                self.detailVC = nil
            }
            context("when view loaded") {
                it("should have initialised all IBOutlets") {
                    expect(self.detailVC.imageView).notTo(beNil())
                }
            }
            
            context("when passed model is nil") {
                beforeEach {
                    self.detailVC = DetailViewController.stub()
                }
                afterEach {
                    self.detailVC = nil
                }
                it("should have initialised all IBOutlets") {
                    expect(self.detailVC.imageView).notTo(beNil())
                }
                
                it("should all elements have default values") {
                    expect(self.detailVC.imageView.image == nil) == true
                }
            }
        }
    }
}
