//
//  OnboardingService.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/09/24.
//

import Foundation

import Moya

enum OnboardingService {
    case postLogin(accessToken : String, platform : String)
}

extension OnboardingService: BaseTargetType {
    var path: String {
        switch self {
        case .postLogin:
            return URLs.postLogin
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLogin:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postLogin(let accessToken, let platform):
            let parameters: [String: Any] = [
                "accessToken": accessToken,
                "platform": platform
            ]
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postLogin:
            return APIConstants.hasTokenHeader
        }
    }
}

