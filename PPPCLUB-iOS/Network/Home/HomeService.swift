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
    
    case getBookmarkCheck(articleID: String)
    case postBookmarkCheck(articleID: String)
    case deleteBookmarkCheck(articleID: String)
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
            
        case .getBookmarkCheck(let articleID):
            return URLs.bookMarkArticle.replacingOccurrences(of: "{articleId}", with: articleID)
        case .postBookmarkCheck(let articleID):
            return URLs.bookMarkArticle.replacingOccurrences(of: "{articleId}", with: articleID)
        case .deleteBookmarkCheck(let articleID):
            return URLs.bookMarkArticle.replacingOccurrences(of: "{articleId}", with: articleID)
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
            
        case .getBookmarkCheck:
            return .get
        case .postBookmarkCheck:
            return .post
        case .deleteBookmarkCheck:
            return .delete
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
            
        case .getBookmarkCheck:
            return .requestPlain
        case .postBookmarkCheck:
            return .requestPlain
        case .deleteBookmarkCheck:
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
            
        case .getBookmarkCheck:
            return APIConstants.noTokenHeader
        case .postBookmarkCheck:
            return APIConstants.noTokenHeader
        case .deleteBookmarkCheck:
            return APIConstants.noTokenHeader
            
        }
    }
}
