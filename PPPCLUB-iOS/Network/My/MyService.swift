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
    case getMySavedSpace
    case getMySavedArticle
}

extension MyService: BaseTargetType {
    var path: String {
        switch self {
        case .getMyInfo:
            return URLs.getMyInfo
        case .getMySavedSpace:
            return URLs.getTotalSavedSpace
        case .getMySavedArticle:
            return URLs.getTotalSavedArticle
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyInfo:
            return .get
        case .getMySavedArticle:
            return .get
        case .getMySavedSpace:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMySavedArticle:
            return .requestPlain
        case .getMyInfo:
            return .requestPlain
        case .getMySavedSpace:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMySavedArticle:
            return APIConstants.noTokenHeader
        case .getMyInfo:
            return APIConstants.noTokenHeader
        case .getMySavedSpace:
            return APIConstants.noTokenHeader
        }
    }
}

