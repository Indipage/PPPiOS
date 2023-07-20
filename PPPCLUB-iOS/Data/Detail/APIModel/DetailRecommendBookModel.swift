//
//  DetailRecommendBookModel.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/19.
//

import UIKit

struct DetailRecommendBookResult: Codable {
    let book: Book
    let comment: String
}

struct Book: Codable {
    let id: Int
    let title: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURL = "imageUrl"
    }
}
