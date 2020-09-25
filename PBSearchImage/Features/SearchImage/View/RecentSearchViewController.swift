//
//  RecentSearchView.swift
//  PBSearchImageTests
//
//  Created by Mohammad Kamar Shad on 9/25/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import UIKit


typealias RecentSearchCompletionBlock = (_ recentSearch: String) -> Void

class RecentSearchViewController: UIViewController {
    @IBOutlet private (set) var tableView: UITableView!
    let viewModel = RecentSearchViewModel(databasePeristable: UserDefaultsManager())
    var recentSearchCompletion: RecentSearchCompletionBlock?
    private var recentSearches: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        recentSearches = viewModel.recentSearches
    }
    
    func reloadRecentSearches() {
        recentSearches = viewModel.recentSearches
        tableView.reloadData()
    }
}

extension RecentSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as? RecentSearchTableViewCell else {
            return UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: RecentSearchTableViewCell.identifier)
        }
        let recentSearch = recentSearches[indexPath.row]
        cell.update(recentSearch)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clickedRecentSearch = recentSearches[indexPath.row]
        recentSearchCompletion?(clickedRecentSearch)
    }
}
