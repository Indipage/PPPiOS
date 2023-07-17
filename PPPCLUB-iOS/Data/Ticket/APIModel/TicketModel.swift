//
//  TicketModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/12.
//

import UIKit

struct TicketResult: Codable {
    let ticketID: Int
    let imageURL: String
    let spaceID: Int

    enum CodingKeys: String, CodingKey {
        case ticketID = "ticketId"
        case imageURL = "imageUrl"
        case spaceID = "spaceId"
    }
}
