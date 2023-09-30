//
//  OnboardingAPI.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/09/24.
//

import Foundation

import Moya

final class OnboardingAPI: BaseAPI {
    static let shared = OnboardingAPI()
    private var onboardingProvider = MoyaProvider<OnboardingService>(plugins: [MoyaLoggingPlugin()])
    private override init() {}
}

extension OnboardingAPI {
    public func postLogin(accessToken: String, platform: Platform, completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.postLogin(accessToken: accessToken, platform: Platform.apple)) { (result) in
            self.disposeNetwork(result,
                                dataModel: OnboardingLoginResult.self,
                                completion: completion
            )
        }
    }
}
