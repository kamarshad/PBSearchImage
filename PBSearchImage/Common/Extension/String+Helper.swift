//
//  String+Helper.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

extension String {
    
    var url: URL? {
        URL(string: self)
    }
    
    var isNonEmpty: Bool {
        return !isEmpty
    }
    
}
