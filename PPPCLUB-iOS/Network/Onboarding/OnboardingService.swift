//
//  OnboardingService.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/09/24.
//

import Foundation

import Moya

enum OnboardingService {
    case postLogin
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
        case .postLogin:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postLogin:
            return APIConstants.hasTokenHeader
        }
    }
}

