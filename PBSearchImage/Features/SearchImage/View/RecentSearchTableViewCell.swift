//
//  RecentSearchTableViewCell.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {
    @IBOutlet private (set) var recentSearchLabel: UILabel!
    
    func update(_ recentSearch: String) {
        recentSearchLabel.text = recentSearch
    }
}

