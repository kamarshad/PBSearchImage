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
    
    var viewModel = ImageListViewModel(networkClient: NetworkClient(with: PBImageNetworkConstants.kSearchImage))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSetUp()
    }
    
    private func doInitialSetUp() {
        viewModel.imageListData.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.onError = { [weak self] error in
            self?.showAlertMessage(error)
        }
    }
    
    // Don't allow empty string
    private func fetchImages(_ keyword: String?) {
        if let queryText = keyword, queryText.isNonEmpty {
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
        let itemHeight = indexPath.row == viewModel.fetchedRecords ? CollectionViewConstants.loadMoreItemHeight :
            CollectionViewConstants.itemHeight
        return CGSize(width: view.frame.size.width - CollectionViewConstants.leftAndRightPadding, height: itemHeight)
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
}

private enum CollectionViewConstants {
    static let itemHeight: CGFloat = 150
    static let loadMoreItemHeight: CGFloat = 60
    static let leftAndRightPadding: CGFloat = 20
}
