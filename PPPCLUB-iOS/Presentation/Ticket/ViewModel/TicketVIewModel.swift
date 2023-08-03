//
//  TicketVIewModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/08/03.
//

import Foundation

final class Observable<T> {
    
    struct Observer<T> {
        weak var observer: AnyObject?
        let block: (T) -> Void
    }
    
    private var observers = [Observer<T>]()
    
    var value: T {
        didSet { notifyObservers() }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func observe(on observer: AnyObject, observerBlock: @escaping (T) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(self.value)
    }
    
    func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    private func notifyObservers() {
        for observer in observers {
            observer.block(self.value)
        }
    }
}


enum DisplayMode {
    case ticket
    case card
}


protocol TicketViewModelInput {
    func ticketToggleButtonDidTap()
    func cardToggleButtonDidTap()
    func checkTicketEmptyView() -> Bool
    func checkCardEmptyView() -> Bool
}

protocol TicketViewViewModelOutput {
    var displayMode: Observable<DisplayMode> { get }
    var toggleMode: Observable<DisplayMode> { get }
}

final class TicketViewModel: TicketViewModelInput, TicketViewViewModelOutput {
    var ticketData: [TicketResult] = []
    var cardData: [TicketCardResult] = []
    
    func checkTicketEmptyView() -> Bool {
        return ticketData.isEmpty
    }
    
    func checkCardEmptyView() -> Bool {
        return cardData.isEmpty
    }
    
    var displayMode: Observable<DisplayMode> = Observable(.ticket)
    var toggleMode: Observable<DisplayMode> = Observable(.ticket)
    
    func ticketToggleButtonDidTap() {
        print("🖕🖕🖕🖕🖕🖕🖕🖕🖕")
        print("티켓 버튼 눌럿을대")
        displayMode.value = .ticket
        
    }
    
    func cardToggleButtonDidTap() {
        print("🖕🖕🖕🖕🖕🖕🖕🖕🖕")
        print("카드 버튼 눌럿을대")
        displayMode.value = .card
    }

    
}

