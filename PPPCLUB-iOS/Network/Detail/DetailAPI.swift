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
}
