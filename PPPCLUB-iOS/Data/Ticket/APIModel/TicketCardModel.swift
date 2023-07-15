//
//  TicketCardModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

struct TicketCardResult: Codable {
    let cardID: Int
    let imageURL, visitedAt: String
    let spaceID: Int
    
    enum CodingKeys: String, CodingKey {
        case cardID = "cardId"
        case imageURL = "imageUrl"
        case visitedAt
        case spaceID = "spaceId"
    }
}


