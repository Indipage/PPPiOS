//
//  HomeAPI.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/19.
//

import UIKit

import Moya

final class HomeAPI: BaseAPI {
    static let shared =  HomeAPI()
    private var homeProvider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
    private override init() {}
}

extension HomeAPI{
    
    public func getAllArticle(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getAllArticle) { (result) in
            self.disposeNetwork(
                result,
                dataModel: [HomeArticleListResult].self,
                completion: completion
            )
        }
    }
    
}
