//
//  GenericResponse.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var code: Int?
    var message: String?
    var data: T?
}
