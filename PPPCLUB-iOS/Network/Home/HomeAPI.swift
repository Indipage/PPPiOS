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
    
    public func getArticleCard(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getArticleCard) { (result) in
            self.disposeNetwork(
                result,
                dataModel: HomeArticleCardResult.self,
                completion: completion
            )
        }
    }

    public func getArticleCheck(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getArticleCheck) { (result) in
            self.disposeNetwork(
                result,
                dataModel: HomeArticleCheckResult.self,
                completion: completion
            )
        }
    }
    
    public func putArticleCheck(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.putArticleCheck) { (result) in
            self.disposeNetwork(
                result,
                dataModel: VoidResult.self,
                completion: completion
            )
        }
    }
    
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