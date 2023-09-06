//
//  OnboardingAgreementView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/09/05.
//

import UIKit

import SnapKit
import Then

final class OnboardingAgreementView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private lazy var backButton = UIButton()
    private let titleLabel = UILabel()
    let agreementCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let agreementHeaderView = OnboardingAgreementCollectionHeaderView()
    lazy var agreementButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        
        style()
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func register() {
        agreementCollectionView.register(
            OnboardingAgreementCollectionViewCell.self,
            forCellWithReuseIdentifier: OnboardingAgreementCollectionViewCell.cellIdentifier
        )
    }
    
    private func style() {
        self.backgroundColor = .pppWhite
        
        backButton.do {
            $0.setImage(Image.backThin, for: .normal)
        }
        
        titleLabel.do {
            $0.text = "서비스 이용 동의"
            $0.font = .pppOnboarding1
            $0.textColor = .pppBlack
        }

        agreementCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = layout
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = false
            $0.backgroundColor = .pppWhite
        }
        
        agreementButton.do {
            $0.backgroundColor = .pppGrey3
            $0.makeCornerRadius(ratio: 7)
            $0.setTitleColor(.pppWhite, for: .normal)
            $0.setTitle("확인", for: .normal)
            $0.isEnabled = false
        }
    }
    
    private func hieararchy() {
        self.addSubviews(
            backButton,
            titleLabel,
            agreementHeaderView,
            agreementCollectionView,
            agreementButton
        )
    }
    
    private func layout() {
        backButton.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).offset(22)
            $0.size.equalTo(33)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(28)
        }
        
        agreementHeaderView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(42)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(33)
        }
        
        agreementCollectionView.snp.makeConstraints {
            $0.top.equalTo(agreementHeaderView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        agreementButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(44)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(22)
            $0.height.equalTo(50)
        }
    }
}





