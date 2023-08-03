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



protocol TicketViewModelInput {
    func ticketToggleButtonDidTap()
    func cardToggleButtonDidTap()
}

protocol TicketViewViewModelOutput {
    var ticketAppear: Observable<Bool> { get }
    var noTicketAppear: Observable<Bool> { get }
    var cardAppear: Observable<Bool> { get }
    var noCardAppear: Observable<Bool> { get }
}

final class TicketViewModel: TicketViewModelInput, TicketViewViewModelOutput {
    var ticketCnt: Int
    var cardCnt: Int
    
    init(ticketCnt: Int, cardCnt: Int) {
        self.ticketCnt = ticketCnt
        self.cardCnt = cardCnt
    }
    
    var ticketAppear: Observable<Bool> = Observable(true)
    var cardAppear: Observable<Bool> = Observable(true)
    var noTicketAppear: Observable<Bool> = Observable(true)
    var noCardAppear: Observable<Bool> = Observable(true)
    
    
    func updateSelectedView() {
        print("일단은 기능 구현 안하고 나머지 부터 먼저 해봅시다")
    }
    
    
    func ticketToggleButtonDidTap() {
        print("티켓 버튼 눌럿을대")
        ticketAppear.value.toggle()
        cardAppear.value.toggle()
    }
    
    func cardToggleButtonDidTap() {
        print("카드 버튼 눌럿을대")
        ticketAppear.value.toggle()
        cardAppear.value.toggle()
    }

    
}

