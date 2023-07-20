//
//  DetailCheckArticleModel.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/18.
//

import UIKit

struct DetailCheckArticleResult: Codable {
    let spaceName, title, spaceType: String?
    let id: Int?
    let isIssued: Bool?
    let imageUrl: String?
}
