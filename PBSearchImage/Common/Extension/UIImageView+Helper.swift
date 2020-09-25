//
//  UIImageView+Helper.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageWith(_ urlString: String,
                      placeholderImage placeholder: UIImage? = nil,
                      scaleFactor: CGFloat = UIScreen.main.scale,
                      completion: DownloadImageBlock? = nil) {
        let processor = DownsamplingImageProcessor(size: bounds.size)
        kf.indicatorType = .activity
        let options: KingfisherOptionsInfo = [
            .processor(processor),
            .transition(.fade(1)),
            .cacheOriginalImage
        ]
        kf.setImage(with: urlString.url,
                    placeholder: placeholder,
                    options: options)
    }
}
