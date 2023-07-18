//
//  DetailService.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/18.
//

import UIKit

import Moya

enum DetailService {
    case getSavedSpace(spaceID: String)
    case postSavedSpace(spaceID: String)
    case deleteSavedSpace(spaceID: String)
    case getCheckArticle(spaceID: String)
    case getSpace(spaceID: String)
    case getFollow(spaceID: String)
    case postFollow(spaceID: String)
    case getRecommendBook(spaceID: String)
}

extension DetailService: BaseTargetType {
    var path: String {
        switch self {
        case .getSavedSpace(let spaceID):
            return URLs.getSavedSpace.replacingOccurrences(of: "{spaceId}", with: spaceID)
        case .postSavedSpace(let spaceID):
            return URLs.getSavedSpace.replacingOccurrences(of: "{spaceId}", with: spaceID)
        case .deleteSavedSpace(let spaceID):
            return URLs.getSavedSpace.replacingOccurrences(of: "{spaceId}", with: spaceID)
        case .getCheckArticle(let spaceID):
            return URLs.getCheckArticle.replacingOccurrences(of: "{spaceId}", with: spaceID)
        case .getSpace(spaceID: let spaceID):
            return URLs.getSpace.replacingOccurrences(of: "{spaceId}", with: spaceID)
        case .getFollow(spaceID: let spaceID):
            return URLs.getFollow.replacingOccurrences(of: "{spaceId}", with: spaceID)
        case .postFollow(spaceID: let spaceID):
            return URLs.postFollow.replacingOccurrences(of: "{spaceId}", with: spaceID)
        case .getRecommendBook(spaceID: let spaceID):
            return URLs.getRecommendBook.replacingOccurrences(of: "{spaceId}", with: spaceID)
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSavedSpace:
            return .get
        case .postSavedSpace:
            return .post
        case .deleteSavedSpace:
            return .delete
        case .getCheckArticle:
            return .get
        case .getSpace:
            return .get
        case .getFollow:
            return .get
        case .postFollow:
            return .post
        case .getRecommendBook:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getSavedSpace:
            return .requestPlain
        case .postSavedSpace:
            return .requestPlain
        case .deleteSavedSpace:
            return .requestPlain
        case .getCheckArticle:
            return .requestPlain
        case .getSpace:
            return .requestPlain
        case .getFollow:
            return .requestPlain
        case .postFollow:
            return .requestPlain
        case .getRecommendBook:
            return .requestPlain
        }
    }
}
