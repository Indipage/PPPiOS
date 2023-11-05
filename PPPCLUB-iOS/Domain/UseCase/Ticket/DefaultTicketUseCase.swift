//
//  DefaultTicketUseCase.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/09/02.
//

import Foundation

import RxSwift
import RxCocoa

final class DefaultTicketUseCase: TicketUseCase {
    private let ticketRepository: TicketRepository
    private let disposeBag = DisposeBag()
    
    var displayMode = BehaviorRelay<DisplayMode>(value: .ticket)
    var toggleMode = BehaviorRelay<DisplayMode>(value: .ticket)
    var ticketData: BehaviorRelay<[TicketResult]> = BehaviorRelay<[TicketResult]>(value: [])
    var cardData: BehaviorRelay<[TicketCardResult]> = BehaviorRelay<[TicketCardResult]>(value: [])
    
    init(displayMode: DisplayMode,
         toggleMode: DisplayMode,
         repository: TicketRepository) {
        self.displayMode.accept(displayMode)
        self.toggleMode.accept(toggleMode)
        self.ticketRepository = repository
    }
    
    func loadTicketView() {
        self.displayMode.accept(.ticket)
    }
    
    func loadCardView() {
        self.displayMode.accept(.card)
    }
    
    func getTicketData() {
        self.ticketRepository.requestTicketAPI() { [weak self] result in
            switch result {
            case .success(let data):
                guard let result = data as? [TicketResult] else { return }
                self?.ticketData.accept(result)
            default:
                break
            }
        }
    }
    
    func getCardData() {
        self.ticketRepository.requestTicketCardAPI() { [weak self] result in
            switch result {
            case .success(let data):
                guard let result = data as? [TicketCardResult] else { return }
                self?.cardData.accept(result)
            default:
                break
            }
        }
    }
}
