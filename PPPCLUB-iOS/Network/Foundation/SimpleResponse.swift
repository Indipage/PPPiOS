//
//  SimpleResponse.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import Foundation

struct SimpleResponse: Codable {
    var code: Int?
    var message: String?
    var data: Data?
    var status: Int?
    var success: Bool?
}
