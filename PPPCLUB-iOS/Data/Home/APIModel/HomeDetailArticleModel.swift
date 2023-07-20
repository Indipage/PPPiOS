//
//  HomeDetailArticleModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/20.
//

import Foundation

struct HomeDetailArticleModel: Codable {
    let id: Int
    let title, content, issueDate, thumbnailURL: String
    let spaceID: Int
    let spaceName, spaceOwner: String

    enum CodingKeys: String, CodingKey {
        case id, title, content, issueDate
        case thumbnailURL = "thumbnailUrl"
        case spaceID = "spaceId"
        case spaceName, spaceOwner
    }
}
