//
//  HomeArticleListModel.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/19.
//

import Foundation

struct HomeArticleListResult: Codable {
    let spaceName, title, spaceType: String
    let id: Int
    let issueDate: String
    let thumbnailURL: String
    let ticketReceived: Bool

    enum CodingKeys: String, CodingKey {
        case spaceName, title, spaceType, id, issueDate
        case thumbnailURL = "thumbnailUrl"
        case ticketReceived
    }
}
