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
    case getAllArticle
}

extension HomeService: BaseTargetType {
    var path: String {
        switch self {
        case .getArticleCard:
            return URLs.weeklyArticle
        case .getAllArticle:
            return URLs.totalArticle
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getArticleCard:
            return .get
        case .getAllArticle:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getArticleCard:
            return .requestPlain
        case .getAllArticle:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getArticleCard:
            return APIConstants.noTokenHeader
        case .getAllArticle:
            return APIConstants.noTokenHeader
        }
    }
}
