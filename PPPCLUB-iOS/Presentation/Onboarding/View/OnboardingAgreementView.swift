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
        agreementCollectionView.register(OnboardingAgreementCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingAgreementCollectionViewCell.cellIdentifier)
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
            $0.setLineSpacing(spacing: 13)
        }

        agreementCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = layout
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = false
            $0.backgroundColor = .pppWhite
        }
    }
    
    private func hieararchy() {
        self.addSubviews(backButton, titleLabel, agreementCollectionView)
    }
    
    private func layout() {
        backButton.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).offset(22)
            $0.size.equalTo(33)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(28)
        }
        
        agreementCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(42)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(171)
        }
    }
}





