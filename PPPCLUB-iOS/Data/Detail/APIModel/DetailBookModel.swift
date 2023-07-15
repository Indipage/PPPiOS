//
//  DetailBookModel.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/16.
//

import UIKit

struct DetailBoolModel {
    var image: [UIImage]
}

extension DetailBoolModel {
    static func dummy() -> DetailBoolModel {
        return DetailBoolModel(image: [Image.mockBook,
                                       Image.mockBook,
                                       Image.mockBook]
        )
    }
}
