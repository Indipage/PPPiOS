//
//  DetailTagModel.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/10.
//

import Foundation

struct Tag {
    let tagList: [String]
}

extension Tag {
    func dummy() -> Tag {
        return Tag(tagList: ["#칵테일", "#카페", "#글쓰기"])
    }
}
