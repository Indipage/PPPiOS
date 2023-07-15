//
//  MySavedArticleModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/15.
//

import Foundation

struct MySavedArticleResult: Codable {
    let spaceName, title, spaceType: String
    let id: Int
    let issueDate: String
    let ticketReceived: Bool
}

