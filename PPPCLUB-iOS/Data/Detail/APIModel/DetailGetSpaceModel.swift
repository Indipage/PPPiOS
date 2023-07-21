//
//  DetailGetSpaceModel.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/19.
//

import UIKit

struct DetailGetSpaceResult: Codable {
    let id: Int
    let name: String
    let imageURL: String?
    let roadAddress, type: String
    let owner, operatingTime, closedDays, introduction, peculiarityTitle, peculiarityContent, peculiarityImageURL: String?
    let tagList: [TagList]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
        case roadAddress, type, owner, operatingTime, closedDays, introduction, peculiarityTitle, peculiarityContent
        case peculiarityImageURL = "peculiarityImageUrl"
        case tagList
    }
}

struct TagList: Codable {
    let id: Int
    let name: String
}
