//
//  TicketCardModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

struct TicketCardModel {
    var image: UIImage?
}

extension TicketCardModel {
    static func mockDummy() -> [TicketCardModel] {
        return [
            TicketCardModel(image: Image.ticket),
            TicketCardModel(image: Image.search),
            TicketCardModel(image: Image.article),
            TicketCardModel(image: Image.mockArticleCard),
            TicketCardModel(image: Image.ticket),
            TicketCardModel(image: Image.search),
            TicketCardModel(image: Image.article),
            TicketCardModel(image: Image.mockArticleCard),
            TicketCardModel(image: Image.ticket),
            TicketCardModel(image: Image.search),
            TicketCardModel(image: Image.article),
            TicketCardModel(image: Image.mockArticleCard)
        ]
    }
}



