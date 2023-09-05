//
//  TicketUseCase.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/09/02.
//

import Foundation

import RxSwift
import RxCocoa

protocol TicketUseCase {
    var displayMode: BehaviorRelay<DisplayMode> { get set }
    var toggleMode: BehaviorRelay<DisplayMode> { get set }
    var ticketData: BehaviorRelay<[TicketResult]> { get set }
    var cardData: BehaviorRelay<[TicketCardResult]> { get set }
    func loadTicketView()
    func loadCardView()
    func getTicketData()
    func getCardData()
}
