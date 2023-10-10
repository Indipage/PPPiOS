//
//  BaseTargetType.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType{ }

extension BaseTargetType{
    
    var baseURL: URL {
        return URL(string: Config.baseURL)! //baseURL 들어갈 장소
    }
    
    var headers: [String : String]? {
        return APIConstants.hasTokenHeader
    }
    
//    var validationType: ValidationType {
//        return .customCodes(Array(0...500).filter { $0 != 401 } )
//    }
   
}
