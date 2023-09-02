//
//  TicketCheckQRCodeViewModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/08/29.
//

import Foundation

import RxSwift
import RxCocoa



final class TicketCheckQRCodeViewModel: ViewModelType {
    
    internal var disposeBag = DisposeBag()
    private let repository: TicketRepository
    private let spaceID: BehaviorRelay<Int?> = BehaviorRelay<Int?>(value: nil)
    
    
    init(spaceID: Int?, repository: TicketRepository) {
        self.spaceID.accept(spaceID)
        self.repository = repository
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
    }
    
    struct Output {
    }
    
    private let qrCodeDataSubject: PublishSubject<String> = PublishSubject<String>()
    
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        
//        input.viewWillAppearEvent.subscribe(onNext: { [weak self] _ in
//            guard let self = self else { return }
//        }).disposed(by: disposeBag)
        
        return Output()
    }
    
}

extension TicketCheckQRCodeViewModel {
    func getSpaceID() -> BehaviorRelay<Int?> {
        return spaceID
    }
    
    func extractNumberFromURL(_ urlString: String) -> String {
        guard let url = URL(string: urlString) else {
            return ""
        }
        
        // URL의 경로 컴포넌트를 가져옴
        let pathComponents = url.pathComponents
        
        // 경로 컴포넌트에서 "space" 다음에 오는 컴포넌트를 반환
        if let index = pathComponents.firstIndex(of: "space"), index + 1 < pathComponents.count {
            return pathComponents[index + 1]
        }
        
        return ""
    }
}


