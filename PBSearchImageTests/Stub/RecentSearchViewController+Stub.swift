//
//  RecentSearchViewController+Stub.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

@testable import PBSearchImage
import UIKit

extension RecentSearchViewController {
    static func stub(with databasePeristable: DataBasePersistable = UserDefaultsManagerMock()) -> RecentSearchViewController? {
        let storyboard = UIStoryboard(name: Storyboard.home, bundle: Bundle.main)
        let recentSearchVC = storyboard.instantiateViewController(withIdentifier: RecentSearchViewController.identifier) as! RecentSearchViewController
        recentSearchVC.viewModel = RecentSearchViewModel(databasePeristable: databasePeristable)
        _ = recentSearchVC.view
        recentSearchVC.simulateViewLifeCycle()
        return recentSearchVC
    }
}
