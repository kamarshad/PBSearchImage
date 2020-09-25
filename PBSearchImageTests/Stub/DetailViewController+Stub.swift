//
//  DetailViewControllerTests+Stub.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

@testable import PBSearchImage
import UIKit

extension DetailViewController {
    
    static func stub(with searchedImages: [ImageDisplayable] = [], selectedImageIndex: Int = 0) -> DetailViewController? {
        let storyboard = UIStoryboard(name: Storyboard.home, bundle: Bundle.main)
        let searchListVC = SearchImageViewController.stub()
        let detailVC = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        detailVC.searchedImages = searchedImages
        detailVC.selectImageIndex = selectedImageIndex
        _ = detailVC.view
        searchListVC?.navigationController?.pushViewController(detailVC, animated: false)
        detailVC.beginAppearanceTransition(true, animated: true)
        detailVC.endAppearanceTransition()
        return detailVC
    }
}
