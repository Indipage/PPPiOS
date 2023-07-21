//
//  TicketService.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/16.
//

import UIKit

import Moya

enum TicketService {
    case getTotalTicket
    case getTotalCard
    case putQRCodeCheck(spaceID: String)
}

extension TicketService: BaseTargetType {
    var path: String {
        switch self {
        case .getTotalTicket:
            return URLs.getTotalTicket
        case .getTotalCard:
            return URLs.getTotalCard
        case .putQRCodeCheck(let spaceID):
            return URLs.visitSpace.replacingOccurrences(of: "{spaceId}", with: spaceID)
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTotalTicket:
            return .get
        case .getTotalCard:
            return .get
        case .putQRCodeCheck:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTotalTicket:
            return .requestPlain
        case .getTotalCard:
            return .requestPlain
        case .putQRCodeCheck:
            return .requestPlain
        }
    }
}

            
