//
//  SearchImageViewController+Stub.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

@testable import PBSearchImage
import UIKit

extension SearchImageViewController {
    static func stub(with fileName: JSONFile = "searchImageResponse") -> SearchImageViewController? {
        let storyboard = UIStoryboard(name: Storyboard.home, bundle: Bundle.main)
        let searchListVC = storyboard.instantiateViewController(withIdentifier: SearchImageViewController.identifier) as! SearchImageViewController
        let mockNetworkClient = NetworkClientMock()
        mockNetworkClient.json = ImageListModel.jsonStub(with: fileName)
        searchListVC.viewModel = ImageListViewModel(networkClient: mockNetworkClient)
        searchListVC.recentSearchViewModel = RecentSearchViewModel(databasePeristable: DatabaseManagerMock())
        _ = searchListVC.view
        searchListVC.simulateViewLifeCycle()
        return searchListVC
    }
}
