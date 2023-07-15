//
//  MyService.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/15.
//

import UIKit

import Moya

enum MyService {
    case getMyInfo
}

extension MyService: BaseTargetType {
    var path: String {
        switch self {
        case .getMyInfo:
            return URLs.getMyInfo
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMyInfo:
            return APIConstants.noTokenHeader
        }
    }
}

