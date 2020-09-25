//
//  SearchImageNetworkAdapter.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

class SearchImageNetworkAdapter {
    private let networkClient: NetworkClientAdapter
    private var currentTask: URLSessionTask?
    
    init(networkClient: NetworkClientAdapter) {
        self.networkClient = networkClient
    }
    
    var cancelRunningTask: Bool = false {
        didSet {
            if cancelRunningTask {
                currentTask?.cancel()
            }
            currentTask = nil
        }
    }
    
    func fetchImages(with queryModel: ImageListRequestModel?,
                     completionHandler: @escaping (_ model: ImageListModel?, _ error: CustomError?) -> Void) {
        guard let queryParam = queryModel?.toDictionary as? QueryParameters else {
            completionHandler(nil, CustomError(type: .invalidRequestFormat))
            return
        }
        currentTask = networkClient.sendRequest(queryParameters: queryParam) { jsonObject, customError in
            if customError == nil,
                let dict = jsonObject,
                let response = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(ImageListModel.self, from: response)
                    completionHandler(model, nil)
                } catch {
                    completionHandler(nil, CustomError(type: .responseMappingError))
                }
            } else {
                completionHandler(nil, customError)
            }
        }
    }
}
