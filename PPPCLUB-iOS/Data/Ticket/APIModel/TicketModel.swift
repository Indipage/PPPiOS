//
//  TicketModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/12.
//

import UIKit

struct TicketModel {
    var image: UIImage
}

extension TicketModel {
    static func mockDummy() -> [TicketModel] {
        return [
            TicketModel(image: Image.mockTicket),
            TicketModel(image: Image.mockTicket),
            TicketModel(image: Image.mockTicket),
            TicketModel(image: Image.mockTicket),
            TicketModel(image: Image.mockTicket),
            TicketModel(image: Image.mockTicket),
            TicketModel(image: Image.mockTicket),
            TicketModel(image: Image.mockTicket),
            TicketModel(image: Image.mockTicket),
            TicketModel(image: Image.mockTicket)
        ]
    }
}

