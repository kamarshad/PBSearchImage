//
//  SearchImageCollectionViewCell.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import UIKit

class SearchImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet private (set) weak var imageView: UIImageView!

    func updateUI(with model: ImageDisplayable) {
        imageView.setImageWith(model.previewURL)
    }
}
