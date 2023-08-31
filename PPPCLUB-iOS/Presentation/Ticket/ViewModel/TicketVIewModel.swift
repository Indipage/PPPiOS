//
//  TicketVIewModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/08/03.
//

import Foundation

import RxSwift
import RxCocoa

enum DisplayMode {
    case ticket
    case card
}

final class TicketViewModel: ViewModelType {
    
    internal var disposeBag = DisposeBag()
    let repository: TicketRepository
    
    init(repository: TicketRepository) {
        self.repository = repository
    }
    
    struct Input {
        let ticketToggleButtonDidTapEvent: Observable<Void>
        let cardToggleButtonDidTapEvent: Observable<Void>
        let requestGetTotalTicket: Observable<Void>
        let requestGetTotalCard: Observable<Void>
    }
    
    struct Output {
        var displayMode: BehaviorRelay<DisplayMode> = BehaviorRelay(value: .ticket)
        var toggleMode: BehaviorRelay<DisplayMode> = BehaviorRelay(value: .ticket)
        var ticketData: BehaviorRelay<[TicketResult]> = BehaviorRelay<[TicketResult]>(value: [])
        var cardData: BehaviorRelay<[TicketCardResult]> = BehaviorRelay<[TicketCardResult]>(value: [])
    }
    
    private let displayMode = BehaviorRelay<DisplayMode>(value: .ticket)
    private let toggleMode = BehaviorRelay<DisplayMode>(value: .ticket)
    let ticketData: BehaviorRelay<[TicketResult]> = BehaviorRelay<[TicketResult]>(value: [])
    let cardData: BehaviorRelay<[TicketCardResult]> = BehaviorRelay<[TicketCardResult]>(value: [])
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        input.ticketToggleButtonDidTapEvent.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.displayMode.accept(.ticket)
        }).disposed(by: disposeBag)
        
        input.cardToggleButtonDidTapEvent.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.displayMode.accept(.card)
        }).disposed(by: disposeBag)
        
        input.requestGetTotalTicket.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.getTotalTicket()
        })
        
        input.requestGetTotalCard.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.getTotalCard()
        })
        
        return Output(
            displayMode: self.displayMode,
            toggleMode: self.toggleMode,
            ticketData: self.ticketData,
            cardData: self.cardData
        )
    }
    
    func moveBy() -> CGFloat? {
        if self.displayMode.value == self.toggleMode.value { return nil }
        else if self.displayMode.value ==  .ticket { return -158 }
        else { return 158 }
    }
    
    func getTotalTicket() {
        repository.requestTicketAPI() { [weak self] result in
            switch result {
            case .success(let data):
                guard let result = data as? [TicketResult] else { return }
                self?.ticketData.accept(result)
            default:
                break
            }
        }
    }
    
    func getTotalCard() {
        repository.requestTicketCardAPI() { [weak self] result in
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

extension TicketViewModel {
    var ticketDataObservable: Observable<[TicketResult]> {
        return ticketData.asObservable()
    }
    
    var cardDataObservable: Observable<[TicketCardResult]> {
        return cardData.asObservable()
    }
}
