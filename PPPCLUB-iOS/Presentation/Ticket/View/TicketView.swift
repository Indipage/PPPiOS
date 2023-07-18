//
//  TicketView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class TicketView: UIView {
    
    // MARK: - UI Components
    
    lazy var ticketToggleView = TicketToggleView()
    let cardView = TicketCardView()
    let ticketView = TicketTicketView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        cardView.isHidden = true
        ticketView.isHidden = false
    }
    
    private func hieararchy() {
        self.addSubviews(ticketToggleView, ticketView, cardView)
    }
    
    private func layout() {
        ticketToggleView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(51.adjusted)
        }
        
        cardView.snp.makeConstraints {
            $0.top.equalTo(self.ticketToggleView.snp.bottom).offset(15.adjusted)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        ticketView.snp.makeConstraints {
            $0.top.equalTo(self.ticketToggleView.snp.bottom).offset(15.adjusted)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
}




