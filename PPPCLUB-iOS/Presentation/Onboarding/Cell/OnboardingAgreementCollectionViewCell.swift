//
//  OnboardingAgreementCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/09/05.
//

import UIKit

import SnapKit
import Then

protocol OnboardingAgreementCollectionViewCellDelegate: AnyObject {
    func checkButtonDidTapped(tag: Int)
}

final class OnboardingAgreementCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var delegate: OnboardingAgreementCollectionViewCellDelegate?
    
    // MARK: - UI Components
    
    private lazy var checkButton =  BaseButton()
    private let agreementLabel = UILabel()
    private lazy var agreementDetailButton = UIButton()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        target()
        
        style()
        hieararchy()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        checkButton.do {
            $0.setImage(Image.check, for: .normal)
            $0.setImage(Image.checkFill, for: .selected)
        }
        
        agreementLabel.do {
            $0.font = .pppCaption1
            $0.textColor = .pppBlack
            $0.setLineSpacing(spacing: 20)
        }
        
        agreementDetailButton.do {
            $0.setTitle("보기", for: .normal)
            $0.setTitleColor(.pppBlack, for: .normal)
            $0.titleLabel?.font = .pppCaption2
            $0.setUnderline()
        }
    }
    
    private func hieararchy() {
        contentView.addSubviews(checkButton, agreementLabel, agreementDetailButton)
    }
    
    private func layout() {
        agreementLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(checkButton.snp.trailing).offset(16)
        }
        
        agreementDetailButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(28)
            $0.height.equalTo(19)
        }
        
        checkButton.snp.makeConstraints {
            $0.centerY.equalTo(agreementLabel)
            $0.leading.equalToSuperview().offset(30)
            $0.size.equalTo(17)
        }
    }
    
    func target() {
        checkButton.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
    }
    
    func dataBind(tag: Int, _ data: OnboardingAgreementModel) {
        checkButton.tag = tag
        checkButton.isSelected = data.isSelected
        agreementLabel.text = data.title
    }
    
    @objc
    private func checkButtonDidTap(_ sender: UIButton) {
        sender.isSelected.toggle()
        delegate?.checkButtonDidTapped(tag: sender.tag)
    }
}
