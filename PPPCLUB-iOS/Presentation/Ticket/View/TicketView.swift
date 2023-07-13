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
    
    // MARK: - Properties
    
    lazy var ticketToggleButton = TicketToggleButton()
    let cardView = TicketCardView()
    let ticketView = TicketTicketView()
    
    // MARK: - UI Components
    
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
        self.addSubviews(ticketToggleButton, ticketView, cardView)
    }
    
    private func layout() {
        ticketToggleButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(50)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(28)
            $0.height.equalToSuperview().multipliedBy(40/Size.height)
        }
        
        cardView.snp.makeConstraints {
            $0.top.equalTo(self.ticketToggleButton.snp.bottom).offset(26)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        ticketView.snp.makeConstraints {
            $0.top.equalTo(self.ticketToggleButton.snp.bottom).offset(26)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
}




