//
//  TicketAPI.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/16.
//

import UIKit

import Moya

final class TicketAPI: BaseAPI {
    static let shared = TicketAPI()
    private var ticketProvider = MoyaProvider<TicketService>(plugins: [MoyaLoggingPlugin()])
    override init() {}
}

extension TicketAPI {
    public func getTotalTicket(completion: @escaping (NetworkResult<Any>) -> Void) {
        ticketProvider.request(.getTotalTicket) { (result) in
            self.disposeNetwork(
                result,
                dataModel: [TicketResult].self,
                completion: completion
            )
        }
    }
    
    public func getTotalCard(completion: @escaping (NetworkResult<Any>) -> Void) {
        ticketProvider.request(.getTotalCard) { (result) in
            self.disposeNetwork(
                result,
                dataModel: [TicketCardResult].self,
                completion: completion
            )
        }
    }
    
    public func putQRCodeCheck(spaceID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        ticketProvider.request(.putQRCodeCheck(spaceID: spaceID)) { (result) in
            self.disposeNetwork(
                result,
                dataModel: TicketQRCodeResult.self,
                completion: completion
            )
        }
    }
}

