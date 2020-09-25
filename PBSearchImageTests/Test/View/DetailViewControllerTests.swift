//
//  DetailViewControllerTests.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
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
        describe("DetailViewController UT's") {
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
            
            context("when passed model is empty") {
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
            context("when image is displayed from passed searchedImages array at selected index") {
                context("and user swipe right to left") {
                    beforeEach {
                        self.searchedImages = ImageListModel.stub()?.records ?? []
                        self.detailVC = DetailViewController.stub(with: self.searchedImages, selectedImageIndex: 0)
                        let swipeGestureLeft = UISwipeGestureRecongnizerMock(target: self.detailVC,
                                                                             action: #selector(DetailViewController.swipeMade(_:)))
                        swipeGestureLeft.perfomSwipe(with: .left)
                    }
                    afterEach {
                        self.detailVC = nil
                    }
                    it("should load the image from next index of searchedImages array") {
                        expect(self.detailVC.selectImageIndex == 1) == true
                    }
                }
                context("and user swipe left to right") {
                    beforeEach {
                        self.searchedImages = ImageListModel.stub()?.records ?? []
                        self.detailVC = DetailViewController.stub(with: self.searchedImages, selectedImageIndex: 3)
                        
                        let swipeGestureLeft = UISwipeGestureRecongnizerMock(target: self.detailVC,
                                                                             action: #selector(DetailViewController.swipeMade(_:)))
                        swipeGestureLeft.perfomSwipe(with: .right)
                    }
                    
                    afterEach {
                        self.detailVC = nil
                    }
                    
                    it("should load the image from previous index of searchedImages array") {
                        expect(self.detailVC.selectImageIndex == 2) == true
                    }
                }
            }
        }
    }
}
