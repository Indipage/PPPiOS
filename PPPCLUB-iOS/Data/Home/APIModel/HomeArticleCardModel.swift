//
//  HomeArticleCardModel.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/19.
//

import Foundation

struct HomeArticleCardResult: Codable {
    let title, spaceName, spaceOwner, thumbnailUrlOfThisWeek, thumbnailUrlOfNextWeek: String
    let id, remainingDays: Int
}
