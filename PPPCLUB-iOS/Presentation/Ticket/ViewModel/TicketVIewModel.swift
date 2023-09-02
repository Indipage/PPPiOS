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
    private let ticketUseCase: TicketUseCase
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let ticketToggleButtonDidTapEvent: Observable<Void>
        let cardToggleButtonDidTapEvent: Observable<Void>
    }
    
    struct Output {
        var displayMode: BehaviorRelay<DisplayMode> = BehaviorRelay(value: .ticket)
        var toggleMode: BehaviorRelay<DisplayMode> = BehaviorRelay(value: .ticket)
        var ticketData: BehaviorRelay<[TicketResult]> = BehaviorRelay<[TicketResult]>(value: [])
        var cardData: BehaviorRelay<[TicketCardResult]> = BehaviorRelay<[TicketCardResult]>(value: [])
    }
    
    init(ticketUseCase: TicketUseCase) {
        self.ticketUseCase = ticketUseCase
    }
    
    private let displayMode = BehaviorRelay<DisplayMode>(value: .ticket)
    private let toggleMode = BehaviorRelay<DisplayMode>(value: .ticket)
    private let ticketData: BehaviorRelay<[TicketResult]> = BehaviorRelay<[TicketResult]>(value: [])
    private let cardData: BehaviorRelay<[TicketCardResult]> = BehaviorRelay<[TicketCardResult]>(value: [])
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppearEvent.subscribe(onNext: { [weak self] in
            self?.ticketUseCase.getTicketData()
            self?.ticketUseCase.getCardData()
        }).disposed(by: disposeBag)
        
        input.ticketToggleButtonDidTapEvent.subscribe(onNext: { [weak self] _ in
            self?.ticketUseCase.getTicketData()
            self?.ticketUseCase.loadTicketView()
        }).disposed(by: disposeBag)
        
        input.cardToggleButtonDidTapEvent.subscribe(onNext: { [weak self] _ in
            self?.ticketUseCase.getCardData()
            self?.ticketUseCase.loadCardView()
        }).disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        
        ticketUseCase.displayMode.subscribe(onNext: { displayMode in
            output.displayMode.accept(displayMode)
        }).disposed(by: disposeBag)
        
        ticketUseCase.toggleMode.subscribe(onNext: { toggleMode in
            output.toggleMode.accept(toggleMode)
        }).disposed(by: disposeBag)
        
        ticketUseCase.ticketData.subscribe(onNext: { ticketData in
            output.ticketData.accept(ticketData)
        }).disposed(by: disposeBag)
        
        ticketUseCase.cardData.subscribe(onNext: { cardData in
            output.cardData.accept(cardData)
        }).disposed(by: disposeBag)
    }
    
    func moveBy() -> CGFloat? {
        if ticketUseCase.displayMode.value == ticketUseCase.toggleMode.value { return nil }
        else if ticketUseCase.displayMode.value ==  .ticket { return -158 }
        else { return 158 }
    }
}

extension TicketViewModel {
    func getTicketData() -> BehaviorRelay<[TicketResult]> {
        return ticketUseCase.ticketData
    }
    
    func getCardData() -> BehaviorRelay<[TicketCardResult]> {
        return ticketUseCase.cardData
    }
}
