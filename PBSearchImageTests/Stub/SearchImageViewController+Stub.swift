//
//  SearchImageViewController+Stub.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 09/05/2020.
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
        let mockedViewModel = ImageListViewModel(networkClient: mockNetworkClient)
        searchListVC.viewModel = mockedViewModel
        _ = searchListVC.view
        searchListVC.simulateViewLifeCycle()
        return searchListVC
    }
}
