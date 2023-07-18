//
//  HomeService.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/19.
//

import UIKit

import Moya

enum HomeService {
    case getArticleCard
    case getArticleCheck
    case putArticleCheck
    case getAllArticle
}

extension HomeService: BaseTargetType {
    var path: String {
        switch self {
        case .getArticleCard:
            return URLs.weeklyArticle
        case .getArticleCheck:
            return URLs.patchSlideArticle
        case .putArticleCheck:
            return URLs.patchSlideArticle
        case .getAllArticle:
            return URLs.totalArticle
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getArticleCard:
            return .get
        case .getArticleCheck:
            return .get
        case .putArticleCheck:
            return .put
        case .getAllArticle:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getArticleCard:
            return .requestPlain
        case .getArticleCheck:
            return .requestPlain
        case .putArticleCheck:
            return .requestPlain
        case .getAllArticle:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getArticleCard:
            return APIConstants.noTokenHeader
        case .getArticleCheck:
            return APIConstants.noTokenHeader
        case .putArticleCheck:
            return APIConstants.noTokenHeader
        case .getAllArticle:
            return APIConstants.noTokenHeader
        }
    }
}
