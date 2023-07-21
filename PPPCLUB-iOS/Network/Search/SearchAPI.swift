//
//  SearchAPI.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/20.
//

import UIKit

import Moya

final class SearchAPI: BaseAPI {
    static let shared = SearchAPI()
    private var searchProvider = MoyaProvider<SearchService>(plugins: [MoyaLoggingPlugin()])
    private override init() {}
}

extension SearchAPI {
    public func getSearchSpace(keyword: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        searchProvider.request(.getSearchSpace(keyword: keyword)) { (result) in
            self.disposeNetwork(result,
                                dataModel: [SpaceData].self,
                                completion: completion
            )
        }
    }
    
    public func getAllSpace(completion: @escaping (NetworkResult<Any>) -> Void) {
        searchProvider.request(.getAllSpace) { (result) in
            self.disposeNetwork(result,
                                dataModel: [SpaceData].self,
                                completion: completion
            )
        }
    }
}
