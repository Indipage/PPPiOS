//
//  HomeTicketCheckModel.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/20.
//

import Foundation

struct HomeTicketCheckResult: Codable {
    let ticket: Ticket
    let hasReceivedTicket: Bool
}

// MARK: - Ticket
struct Ticket: Codable {
    let id: Int
    let ticketImageURL, cardImageURL, ticketForArticleImageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case ticketImageURL = "ticketImageUrl"
        case cardImageURL = "cardImageUrl"
        case ticketForArticleImageURL = "ticketForArticleImageUrl"
    }
}
