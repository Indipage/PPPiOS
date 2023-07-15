//
//  MyAPI.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/15.
//

import UIKit

import Moya

final class MyAPI: BaseAPI {
    static let shared = MyAPI()
    private var myProvider = MoyaProvider<MyService>(plugins: [MoyaLoggingPlugin()])
    private override init() {}
}

extension MyAPI{
    public func getMyInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.getMyInfo) { (result) in
            self.disposeNetwork(
                result,
                dataModel: MyUserInfoResult.self,
                completion: completion
            )
        }
    }
    
    public func getSavedSpace(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.getMySavedSpace) { (result) in
            self.disposeNetwork(
                result,
                dataModel: [MySavedSpaceResult].self,
                completion: completion
            )
        }
    }
}
