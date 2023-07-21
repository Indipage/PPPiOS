//
//  TicketFailureView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class TicketFailureView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI Components

    private let failView = UIView()
    private let failImage = UIImageView()
    private let failLabel = UILabel()
    lazy var exitButton = UIButton()
    lazy var tryButton = UIButton()
    
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
        self.do {
            $0.backgroundColor = .clear
        }
        
        failView.do {
            $0.backgroundColor = .pppWhite
            $0.makeCornerRadius(ratio: 16)
        }
        
        failImage.do {
            $0.image = Image.qrFail
        }
        
        failLabel.do {
            $0.text = "QR 코드 인식에 실패했어요.\n다시 시도해보세요!"
            $0.textColor = .pppBlack
            $0.font = .pppBody6
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
        exitButton.do {
            $0.setTitle("나가기", for: .normal)
            $0.setTitleColor(.pppGrey4, for: .normal)
            $0.titleLabel?.font = .pppBody3
            $0.backgroundColor = .pppGrey2
            $0.makeCornerRadius(ratio: 6)
        }
        
        tryButton.do {
            $0.setTitle("다시 시도하기", for: .normal)
            $0.setTitleColor(.pppWhite, for: .normal)
            $0.titleLabel?.font = .pppBody3
            $0.backgroundColor = .pppMainPurple
            $0.makeCornerRadius(ratio: 6)
        }
    }
    
    private func hieararchy() {
        self.addSubview(failView)
        //contentView.addSubview(failView)
        failView.addSubviews(failImage, failLabel, exitButton, tryButton)
    }
    
    private func layout() {
        failView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(299/Size.width)
            $0.height.equalToSuperview().multipliedBy(317/Size.height)
        }
        
        failImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self).multipliedBy(156/Size.width)
            $0.height.equalTo(self).multipliedBy(117/Size.height)
        }
        
        failLabel.snp.makeConstraints {
            $0.top.equalTo(self.failImage.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        exitButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(19)
            $0.bottom.equalToSuperview().inset(23)
            $0.width.equalTo(self).multipliedBy(105/Size.width)
            $0.height.equalTo(self).multipliedBy(52/Size.height)
        }
        
        tryButton.snp.makeConstraints {
            $0.leading.equalTo(self.exitButton.snp.trailing).offset(10)
            $0.bottom.equalToSuperview().inset(23)
            $0.width.equalTo(self).multipliedBy(147/Size.width)
            $0.height.equalTo(self).multipliedBy(52/Size.height)
        }
    }
}






