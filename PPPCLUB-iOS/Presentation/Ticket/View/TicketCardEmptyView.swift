//
//  TicketCardEmptyView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class TicketCardEmptyView: UIView {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    private let noCardImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
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
        noCardImageView.do {
            $0.image = Image.noTicket
        }
        
        titleLabel.do {
            $0.text = "발급받은 티켓이 없어요!"
            $0.textColor = .pppGrey5
            $0.font = .pppBody1
        }
        
        subTitleLabel.do {
            $0.text = "아티클을 읽고 티켓을 받아보세요"
            $0.textColor = .pppGrey4
            $0.font = .pppBody4
        }
    }
    
    private func hieararchy() {
        self.addSubviews(noCardImageView, titleLabel, subTitleLabel)
    }
    
    private func layout() {
        noCardImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(215)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(103)
            $0.height.equalTo(92)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.noCardImageView.snp.bottom).offset(23)
            $0.centerX.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }
}
