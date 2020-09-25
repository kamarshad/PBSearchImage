//
//  ImageListViewModel.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

class ImageListViewModel {
    private let networkAdapter: ImageListNetworkAdapter
    private let networkClient: NetworkClientAdapter
    private (set) var imageListData: DynamicType<[ImageDisplayable]> = DynamicType([])
    private (set) var isFetchRecordInProgress = false
    private (set) var imageList: ImageListModel?
    private (set) var pageNo: Int = 1
    
    var onError: ((CustomError?) -> Void)?
    
    init(networkClient: NetworkClientAdapter) {
        self.networkClient = networkClient
        self.networkAdapter = ImageListNetworkAdapter(networkClient: networkClient)
    }
    
    func getImages(keyword: String) {
        pageNo = 1
        fetchImages(keyword: keyword,pageNo: pageNo, releasePreviousResult: true)
    }
    
    func getMoreImages(keyword: String) {
        if !isFetchRecordInProgress && canLoadMoreRecords {
            isFetchRecordInProgress = true
            fetchImages(keyword: keyword, pageNo: pageNo + 1, updatePageNo: true)
        }
    }
    
    var numberOfItems: Int {
        var totalRecords = fetchedRecords
        if imageListData.value.isNonEmpty && canLoadMoreRecords {
            totalRecords += 1
        }
        return totalRecords
    }
    
    var fetchedRecords: Int {
        return imageListData.value.count
    }
    
    var canLoadMoreRecords: Bool {
        guard let imageList = imageList else { return true }
        return imageList.totalAvailableRecords > imageList.fetchedRecords
    }
    
    private var updatePageCount: Bool = false {
        didSet {
            pageNo = updatePageCount ? pageNo + 1 : pageNo
        }
    }
    
    private func fetchImages(keyword: String,
                             pageNo: Int,
                             releasePreviousResult: Bool = false,
                             updatePageNo: Bool = false) {
        let requestModel = prepareRequestModel(query: keyword)
        if requestModel.apiKey.isEmpty {
            onError?(CustomError(type: .apiKeyMissing))
            return
        }
        networkAdapter.cancelRunningTask = true
        networkAdapter.fetchImages(with: requestModel) { [weak self] model, error in
            self?.isFetchRecordInProgress = false
            if let model = model {
                self?.handleResponse(model: model, releasePreviousResult: releasePreviousResult, updatePageNo: updatePageNo)
            } else {
                self?.onError?(error)
            }
        }
    }
    
    private func prepareRequestModel(query: String) -> ImageListRequestModel {
        return ImageListRequestModel(query: query, pageNo: "\(pageNo)", apiKey: APIConstant.apiKey)
    }
    
    private func handleResponse(model: ImageListModel, releasePreviousResult: Bool, updatePageNo: Bool) {
        updatePageCount = updatePageNo
        if releasePreviousResult {
            imageList = nil
        }
        var previousImageResults = imageList?.records ?? []
        if imageList == nil {
            imageList = model
        }
        previousImageResults.append(contentsOf: model.records)
        imageList?.records = previousImageResults
        imageListData.value = previousImageResults
    }
}
