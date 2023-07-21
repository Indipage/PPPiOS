//
//  MySavedBookStore.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/15.
//

import Foundation

struct MySavedSpaceResult: Codable {
    let id: Int
    let name, imageURL, address: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
        case address
    }
}
