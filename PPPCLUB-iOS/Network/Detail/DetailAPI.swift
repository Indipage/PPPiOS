//
//  DetailAPI.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/18.
//

import UIKit

import Moya

final class DetailAPI: BaseAPI {
    static let shared = DetailAPI()
    private var detailProvider = MoyaProvider<DetailService>(plugins: [MoyaLoggingPlugin()])
    private override init() {}
}

extension DetailAPI {
    public func getSavedSpace(spaceID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        detailProvider.request(.getSavedSpace(spaceID: spaceID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: DetailSavedBookMarkResult.self,
                                completion: completion
            )
        }
    }
    
    public func postSavedSpace(spaceID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        detailProvider.request(.postSavedSpace(spaceID: spaceID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: VoidResult.self,
                                completion: completion
            )
        }
    }
    
    public func deleteSavedSpace(spaceID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        detailProvider.request(.deleteSavedSpace(spaceID: spaceID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: VoidResult.self,
                                completion: completion
            )
        }
    }
    
    public func getCheckArticle(spaceID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        detailProvider.request(.getCheckArticle(spaceID: spaceID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: DetailCheckArticleResult.self,
                                completion: completion
            )
        }
    }
    
    public func getSpace(spaceID:String, completion: @escaping (NetworkResult<Any>) -> Void) {
        detailProvider.request(.getSpace(spaceID: spaceID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: DetailGetSpaceResult.self,
                                completion: completion
            )
        }
    }
    
    public func getFollow(spaceID:String, completion: @escaping (NetworkResult<Any>) -> Void) {
        detailProvider.request(.getFollow(spaceID: spaceID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: DetailGetFollowResult.self,
                                completion: completion
            )
        }
    }
    
    public func postFollow(spaceID:String, completion: @escaping (NetworkResult<Any>) -> Void) {
        detailProvider.request(.postFollow(spaceID: spaceID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: VoidResult.self,
                                completion: completion
            )
        }
    }
}
