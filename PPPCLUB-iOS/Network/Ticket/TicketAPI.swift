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
    private override init() {}
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
    
    public func putQRCodeCheck(qrResult: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        ticketProvider.request(.putQRCodeCheck(qrResult: qrResult)) { (result) in
            self.disposeNetwork(
                result,
                dataModel: VoidResult.self,
                completion: completion
            )
        }
    }
}

