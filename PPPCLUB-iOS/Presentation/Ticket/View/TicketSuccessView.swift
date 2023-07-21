//
//  TicketSuccessView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class TicketSuccessView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    let cardImageView = UIImageView()
    lazy var cardViewButton = UIButton()
    
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
        titleLabel.do {
            $0.text = "인증 성공!"
            $0.font = .pppSubHead1
            $0.textAlignment = .center
            $0.textColor = .pppBlack
        }
        
        subTitleLabel.do {
            $0.text = "카드를 획득했어요!"
            $0.font = .pppBody2
            $0.textAlignment = .center
            $0.textColor = .pppBlack
        }
        
        cardImageView.do {
            $0.backgroundColor = .gray
            $0.makeCornerRadius(ratio: 15)
            $0.transform = .init(rotationAngle: 9.15)
            $0.makeShadow(color: .black, offset: CGSize(width: -2, height: 3), radius: 4.2727, opacity: 0.25)
        }
        
        cardViewButton.do {
            $0.backgroundColor = .pppMainPurple
            $0.setTitle("카드 보러가기", for: .normal)
            $0.setTitleColor(.pppWhite, for: .normal)
            $0.titleLabel?.font = .pppBody1
            $0.makeCornerRadius(ratio: 6)
        }
    }
    
    private func hieararchy() {
        self.addSubviews(titleLabel, subTitleLabel, cardImageView, cardViewButton)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(80.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        cardImageView.snp.makeConstraints {
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(39.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(243)
            $0.height.equalTo(384.adjusted)
        }
        
        cardViewButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(319)
            $0.height.equalTo(60.adjusted)
        }
        
    }
}






