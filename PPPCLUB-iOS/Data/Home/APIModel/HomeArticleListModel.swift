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
    let ticketReceived: Bool
}
