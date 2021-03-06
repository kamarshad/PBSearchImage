//
//  SearchImageViewController.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import UIKit

class SearchImageViewController: UIViewController {
    @IBOutlet private (set) weak var collectionView: UICollectionView!
    @IBOutlet private (set) weak var searchBar: UISearchBar!
    private var canShowAlert: Bool = false
    var viewModel = ImageListViewModel(networkClient: NetworkClient(with: PBNetworkConstants.kSearchImage))
    lazy var recentSearchViewModel: RecentSearchViewModel = {
        return RecentSearchViewModel(databasePeristable: DatabaseManager())
    }()
    lazy var recentSearchController: RecentSearchViewController? = {
        return self.storyboard?.instantiateViewController(withIdentifier: RecentSearchViewController.identifier) as? RecentSearchViewController
    }()
    private var searchQuery: String = Constants.emptyString {
        didSet {
            searchBar.text = searchQuery
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSetUp()
    }
    
    private func doInitialSetUp() {
        viewModel.imageListData.addAndNotify(observer: self) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.reloadData()
            if weakSelf.canShowAlert && weakSelf.viewModel.imageListData.value.isEmpty {
                weakSelf.showAlertMessage(message: UIStringConstants.noRecordFound)
            } else if weakSelf.searchQuery.isNonEmpty {
                weakSelf.recentSearchViewModel.saveSearch(weakSelf.searchQuery)
            }
        }
        viewModel.onError = { [weak self] error in
            self?.showAlertMessage(error)
        }
    }
    
    private func configureRecentSearchVC() {
        removeRecentSearchVC()
        // If there is no saved search found don't configure the recent search screen
        guard recentSearchViewModel.recentSearches.isNonEmpty, let recentSearchVC = recentSearchController else { return }
        addChild(recentSearchVC)
        let originY = searchBar.frame.size.height + searchBar.frame.origin.y
        recentSearchVC.view.frame = CGRect(x: view.frame.origin.y, y: originY, width: view.frame.size.width, height: SearchImageConstants.recentSearchViewHeight)
        view.addSubview(recentSearchVC.view)
        view.bringSubviewToFront(recentSearchVC.view)
        recentSearchVC.recentSearchCompletion = { recentSearch in
            // Let's trigger the api call only if the searchbar is not having the same text
            if recentSearch != self.searchBar.text {
                self.fetchImages(recentSearch)
            }
            self.removeRecentSearchVC()
        }
        recentSearchVC.reloadRecentSearches()
    }
    
    private func removeRecentSearchVC() {
        willMove(toParent: nil)
        recentSearchController?.view.removeFromSuperview()
        recentSearchController?.removeFromParent()
        view.endEditing(true)
    }
    
    // Don't allow empty string
    func fetchImages(_ keyword: String?) {
        if let queryText = keyword, queryText.isNonEmpty {
            searchQuery = queryText
            canShowAlert = true
            removeRecentSearchVC()
            viewModel.getImages(keyword: queryText)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailViewController.identifier,
            let viewController = segue.destination as? DetailViewController,
            let selectImageIndex = sender as? Int {
            viewController.searchedImages = viewModel.imageListData.value
            viewController.selectImageIndex = selectImageIndex
        }
    }
}

extension SearchImageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rowNo = indexPath.row
        let records = viewModel.fetchedRecords
        if rowNo < records {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchImageCollectionViewCell.identifier,
                                                          for: indexPath)
            let model: ImageDisplayable = viewModel.imageListData.value[indexPath.row]
            (cell as? SearchImageCollectionViewCell)?.updateUI(with: model)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadMoreRecordCollectionViewCell.identifier, for: indexPath)
        let loadMoreRedCell = cell as? LoadMoreRecordCollectionViewCell
        loadMoreRedCell?.showLoader()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        removeRecentSearchVC()
        performSegue(withIdentifier: DetailViewController.identifier, sender: indexPath.row)
    }
    
    // As soon user reaches to last item load more images from server
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.fetchedRecords, cell.isKind(of: LoadMoreRecordCollectionViewCell.self) {
            if let queryText = searchBar.text, queryText.isNonEmpty {
                (cell as? LoadMoreRecordCollectionViewCell)?.showLoader()
                viewModel.getMoreImages(keyword: queryText)
                canShowAlert = false
            } else {
                (cell as? LoadMoreRecordCollectionViewCell)?.hideLoader()
            }
        }
    }
}

extension SearchImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = indexPath.row == viewModel.fetchedRecords ? SearchImageConstants.loadMoreItemHeight :
            SearchImageConstants.itemHeight
        return CGSize(width: view.frame.size.width - SearchImageConstants.leftAndRightPadding, height: itemHeight)
    }
}

extension SearchImageViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        removeRecentSearchVC()
        view.endEditing(true)
    }
}

extension SearchImageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == Constants.lineTermination {
            searchBar.resignFirstResponder()
            fetchImages(searchBar.text)
        }
        let finalEnteredString = (searchBar.text ?? Constants.emptyString) + text
        // pixabay does not support more than specified length query string
        // https://pixabay.com/api/docs/
        return finalEnteredString.count <= Constants.maxAllowedKeywordLength
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool  {
        configureRecentSearchVC()
        return true
    }
}

private enum SearchImageConstants {
    static let itemHeight: CGFloat = 150
    static let loadMoreItemHeight: CGFloat = 60
    static let leftAndRightPadding: CGFloat = 20
    static let recentSearchViewHeight: CGFloat = 130
}
