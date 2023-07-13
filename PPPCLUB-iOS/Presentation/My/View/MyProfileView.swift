//
//  MyProfileView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyProfileView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let profileImageVIew = UIImageView()
    private let profileNameLabel = UILabel()
    private let profileNickNameLabel = UILabel()
    private let savedView = UIView()
    private let savedArticleButton = MySavedView(frame: .init(), savedViewType: .article)
    private let savedBookStoreButton = MySavedView(frame: .init(), savedViewType: .store)
    
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        profileImageVIew.makeCornerRound(ratio: 2)
    }
    
    // MARK: - Custom Method
    
    private func style() {
        profileImageVIew.do {
            $0.backgroundColor = .pppGrey2
            $0.makeCornerRound(ratio: 2)
        }
        
        profileNameLabel.do {
            $0.text = "김지안"
            $0.font = .pppBody3
            $0.textColor = .pppBlack
        }
        
        profileNickNameLabel.do {
            $0.text = "bright98"
            $0.font = .pppEnCaption
            $0.textColor = .pppGrey5
        }
        
        savedView.do {
            $0.backgroundColor = .pppGrey1
        }
    }
    
    private func hieararchy() {
        self.addSubviews(
            profileImageVIew,
            profileNameLabel,
            profileNickNameLabel,
            savedView
        )
        
        savedView.addSubviews(savedArticleButton, savedBookStoreButton)
    }
    
    private func layout() {
        profileImageVIew.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(84)
        }
        
        profileNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.profileImageVIew.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        profileNickNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.profileNameLabel.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
        }
        
        savedView.snp.makeConstraints {
            $0.top.equalTo(self.profileNickNameLabel.snp.bottom).offset(20)
            $0.width.equalToSuperview()
            $0.height.equalTo(188)
        }
        
        savedArticleButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.equalToSuperview().offset(28)
            $0.width.equalTo(154)
            $0.height.equalTo(132)
        }
        
        savedBookStoreButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().inset(28)
            $0.width.equalTo(154)
            $0.height.equalTo(132)
        }
    }
}


