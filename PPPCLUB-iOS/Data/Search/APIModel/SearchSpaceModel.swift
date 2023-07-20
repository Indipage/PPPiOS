//
//  SearchSpaceModel.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/20.
//

import UIKit

struct SearchGetSpaceResult: Codable {
    let data: [SpaceData]
}

struct SpaceData: Codable {
    let spaceID: Int
    let spaceName, address: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case spaceID = "spaceId"
        case spaceName, address
        case imageURL = "imageUrl"
    }
}
