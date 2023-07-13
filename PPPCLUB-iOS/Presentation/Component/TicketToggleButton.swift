//
//  TicketToggleButton.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/13.
//

import UIKit

import SnapKit

final class TicketToggleButton: UIView {
    
    //MARK: - Properties
    
    var isOn = false
    
    //MARK: - UI Components
    
    lazy var toggleButton = BaseButton()
    lazy var ticketToggleButton = UIButton()
    lazy var cardToggleButton = UIButton()
    let ticketLabel = UILabel()
    let cardLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        self.do {
            $0.backgroundColor = .pppGrey2
            $0.makeCornerRadius(ratio: 20)
        }
        
        toggleButton.do {
            $0.backgroundColor = .pppMainPurple
            $0.makeCornerRadius(ratio: 18)
        }
        
        ticketLabel.do {
            $0.text = "티켓"
            $0.textColor = .pppWhite
            $0.textAlignment = .center
            $0.font = .pppBody5
        }
        
        cardLabel.do {
            $0.text = "카드"
            $0.textColor = .pppGrey4
            $0.textAlignment = .center
            $0.font = .pppBody5
        }
    }
    
    private func hierarchy() {
        self.addSubviews(ticketToggleButton, cardToggleButton, toggleButton, ticketLabel, cardLabel)
    }
    
    private func layout() {
        ticketLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(68)
        }
        
        ticketToggleButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.leading.bottom.equalToSuperview().inset(3)
            $0.width.equalTo(155)
        }
        
        cardToggleButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.trailing.bottom.equalToSuperview().inset(3)
            $0.width.equalTo(155)
        }
        
        cardLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(68)
        }
        
        toggleButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.leading.bottom.equalToSuperview().inset(3)
            $0.width.equalTo(155)
        }
    }
}
