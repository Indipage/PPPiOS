//
//  TicketQRCodeModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/21.
//

import UIKit

struct TicketQRCodeResult: Codable {
    let cardImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case cardImageURL = "cardImageUrl"
    }
}
