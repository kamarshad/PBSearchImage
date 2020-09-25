//
//  DetailViewController.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private (set) weak var imageView: UIImageView!
    var searchedImages: [ImageDisplayable] = []
    var selectImageIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSetUp()
    }
    
    private func doInitialSetUp() {
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeMade(_:)))
        swipeGestureLeft.direction = .left
        imageView.addGestureRecognizer(swipeGestureLeft)
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeMade(_:)))
        swipeGestureRight.direction = .right
        imageView.addGestureRecognizer(swipeGestureRight)
        imageView.isUserInteractionEnabled = true
        loadImage()
    }
    
    private func loadImage() {
        if selectImageIndex < searchedImages.count {
            let model = searchedImages[selectImageIndex]
            imageView.setImageWith(model.largeImageURL)
        }
    }
    
    @objc private func swipeMade(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if selectImageIndex < searchedImages.count {
                selectImageIndex += 1
                loadImage()
            }
        } else if sender.direction == .right {
            if selectImageIndex > 0 {
                selectImageIndex -= 1
                loadImage()
            }
        }
    }
}
