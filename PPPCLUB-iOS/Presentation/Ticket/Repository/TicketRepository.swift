//
//  TicketRepository.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/08/31.
//

import Foundation

protocol TicketRepository {
    func requestTicketAPI(completion: @escaping (NetworkResult<Any>) -> Void)
    func requestTicketCardAPI(completion: @escaping (NetworkResult<Any>) -> Void)
    func requestQRCodeAPI(spaceID: String, completion: @escaping (NetworkResult<Any>) -> Void)
}

class DefaultTicketRepository: TicketRepository {
    func requestTicketAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        TicketAPI.shared.getTotalTicket(completion: completion)
    }
    
    func requestTicketCardAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        TicketAPI.shared.getTotalCard(completion: completion)
    }
    
    func requestQRCodeAPI(spaceID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        TicketAPI.shared.putQRCodeCheck(spaceID: spaceID, completion: completion)
    }
    
}
