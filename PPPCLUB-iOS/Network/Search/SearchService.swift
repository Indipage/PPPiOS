//
//  SearchService.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/20.
//

import UIKit

import Moya

enum SearchService {
    case getSearchSpace(keyword: String)
    case getAllSpace
}

extension SearchService: BaseTargetType {
    var path: String {
        switch self {
        case .getSearchSpace(_):
            return URLs.getSearchSpace
        case .getAllSpace:
            return URLs.getSearchSpace
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSearchSpace:
            return .get
        case .getAllSpace:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getSearchSpace(let keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: URLEncoding.queryString)
        case .getAllSpace:
            return .requestPlain
        }
    }
}
