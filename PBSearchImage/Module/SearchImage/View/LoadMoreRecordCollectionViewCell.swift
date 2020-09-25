//
//  LoadMoreRecordCollectionViewCell.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import UIKit

class LoadMoreRecordCollectionViewCell: UICollectionViewCell {
    @IBOutlet private (set) weak var loader: UIActivityIndicatorView!
    @IBOutlet private (set) weak var loaderContainerView: UIView!

    override func awakeFromNib() {
        // keep it hidden by default
        hideLoader()
    }
    
    func showLoader() {
        loaderContainerView.isHidden = false
        loader.startAnimating()
    }
    
    func hideLoader() {
        loaderContainerView.isHidden = true
        loader.stopAnimating()
    }
}
