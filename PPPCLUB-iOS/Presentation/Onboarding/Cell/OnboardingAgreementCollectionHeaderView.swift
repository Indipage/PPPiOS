//
//  OnboardingAgreementCollectionHeaderView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/09/05.
//

import UIKit

import SnapKit
import Then

final class OnboardingAgreementCollectionHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - UI Components
    
    private lazy var allAgreementCheckButton = UIButton()
    private let allAgreementTitleLabel = UILabel()

    // MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        allAgreementCheckButton.do {
            $0.setImage(Image.check, for: .normal)
            $0.setImage(Image.checkFill, for: .selected)
        }
        
        allAgreementTitleLabel.do {
            $0.text = "약관 전체 동의"
            $0.textColor = .pppBlack
            $0.font = .pppTitle3
            $0.setLineSpacing(spacing: 18)
        }
        
    }
    
    private func hierarchy() {
        contentView.addSubviews(allAgreementCheckButton, allAgreementTitleLabel)
    }
    
    private func layout() {
        allAgreementCheckButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(29)
            $0.size.equalTo(20)
        }
        
        allAgreementTitleLabel.snp.makeConstraints {
            $0.top.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
        }
    }
        
}

extension HomeArticleHeaderView {
   
}


