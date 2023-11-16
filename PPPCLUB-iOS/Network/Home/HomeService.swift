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
    case patchArticleCheck
    case getAllArticle
    case getDetailArticle(articleID: String)
    
    case getBookmarkCheck(articleID: String)
    case postBookmarkCheck(articleID: String)
    case deleteBookmarkCheck(articleID: String)
    
    case getTicketCheck(spaceID: String)
    case postTicketGet(spaceID: String)
}

extension HomeService: BaseTargetType {
    var path: String {
        switch self {
        case .getArticleCard:
            return URLs.weeklyArticle
        case .getArticleCheck:
            return URLs.patchSlideArticle
        case .patchArticleCheck:
            return URLs.patchSlideArticle
        case .getAllArticle:
            return URLs.totalArticle
        case .getDetailArticle(let articleID):
            return URLs.detailArticle.replacingOccurrences(of: "{articleId}", with: articleID)
            
        case .getBookmarkCheck(let articleID):
            return URLs.getSavedArticle.replacingOccurrences(of: "{articleId}", with: articleID)
        case .postBookmarkCheck(let articleID):
            return URLs.postSavedArticle.replacingOccurrences(of: "{articleId}", with: articleID)
        case .deleteBookmarkCheck(let articleID):
            return URLs.deleteSavedArticle.replacingOccurrences(of: "{articleId}", with: articleID)
            
        case .getTicketCheck(let spaceID):
            return URLs.getTicket.replacingOccurrences(of: "{spaceId}", with: spaceID)
        case .postTicketGet(let spaceID):
            return URLs.postTicket.replacingOccurrences(of: "{spaceId}", with: spaceID)
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getArticleCard:
            return .get
        case .getArticleCheck:
            return .get
        case .patchArticleCheck:
            return .patch
        case .getAllArticle:
            return .get
        case .getDetailArticle:
            return .get
            
        case .getBookmarkCheck:
            return .get
        case .postBookmarkCheck:
            return .post
        case .deleteBookmarkCheck:
            return .delete
            
        case .getTicketCheck:
            return .get
        case .postTicketGet:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getArticleCard:
            return .requestPlain
        case .getArticleCheck:
            return .requestPlain
        case .patchArticleCheck:
            return .requestPlain
        case .getAllArticle:
            return .requestPlain
        case .getDetailArticle:
            return .requestPlain
            
        case .getBookmarkCheck:
            return .requestPlain
        case .postBookmarkCheck:
            return .requestPlain
        case .deleteBookmarkCheck:
            return .requestPlain
            
        case .getTicketCheck:
            return .requestPlain
        case .postTicketGet:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getArticleCheck:
            return APIConstants.noTokenHeader
        default:
            return APIConstants.hasTokenHeader
        }
    }
}
