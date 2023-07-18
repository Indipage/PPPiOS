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
        }
    }
}
