//
//  PPPToastMessage.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/11/01.
//

import UIKit

import SnapKit
import Then

class PPPToastMessage: UIView {
    
    //MARK: - UI Components
    
    private let toastMessageLabel = UILabel()
    let toastButton = UIButton()
    
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
            $0.backgroundColor = .pppGrey9
            $0.layer.cornerRadius = 6
        }
        
        toastMessageLabel.do {
            $0.text = "티켓을 받았어요!"
            $0.font = .pppBody4
            $0.textColor = .pppWhite
        }
        
        toastButton.do {
            $0.setTitle("티켓함 가기", for: .normal)
            $0.titleLabel?.font = .pppBody3
            $0.setTitleColor(.pppMainLightGreen, for: .normal)
            $0.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapEvent)))
        }
    }
    
    private func hierarchy() {
        self.addSubviews(toastMessageLabel, toastButton)
    }
    
    private func layout() {
        
        toastMessageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        toastButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(16)
        }
    }
    
    @objc
    private func tapEvent() {
        print("💗🍎")
    }
}
