//
//  OnboardingLoginView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/09/05.
//

import UIKit

import AuthenticationServices
import SnapKit
import Then


final class OnboardingLoginView: UIView {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let logoImageView = UIImageView()
    public lazy var appleLoginButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    
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
        self.backgroundColor = .pppWhite
        
        titleLabel.do {
            $0.text = "책과 공간을 사랑하는 \n당신을 위한 이야기"
            $0.font = .pppOnboarding1
            $0.textAlignment = .left
            $0.setLineSpacing(spacing: 13)
            $0.numberOfLines = 2
        }
        
        logoImageView.do {
            $0.image = Image.pppLogo
        }
        
        appleLoginButton.do {
            $0.makeCornerRadius(ratio: 5)
        }
    }
    
    private func hieararchy() {
        self.addSubviews(titleLabel, logoImageView, appleLoginButton)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(142)
            $0.leading.equalToSuperview().offset(42)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(37)
            $0.leading.equalToSuperview().offset(42)
            $0.width.equalTo(198)
            $0.height.equalTo(156)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(29)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(317)
            $0.height.equalTo(50)
        }
    }
}





