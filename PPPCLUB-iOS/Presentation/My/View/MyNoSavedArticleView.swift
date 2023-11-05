//
//  MyNoSavedArticleView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/11/05.
//

import UIKit

import SnapKit
import Then

final class MyNoSavedArticleView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let noSavedArticleImageView = UIImageView()
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
        noSavedArticleImageView.do {
            $0.image = Image.noSavedArticle
        }
        titleLabel.do {
            $0.text = "아직 저장한 아티클이 없어요"
            $0.textColor = .pppGrey5
            $0.font = .pppBody1
            $0.textAlignment = .left
        }
        subTitleLabel.do {
            $0.text = "마음에 드는 아티클을 저장해보세요"
            $0.textColor = .pppGrey4
            $0.font = .pppBody4
            $0.textAlignment = .left
        }
    }
    
    private func hieararchy() {
        self.addSubviews(
            noSavedArticleImageView,
            titleLabel,
            subTitleLabel
        )
    }
    
    private func layout() {
        noSavedArticleImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(190)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(179.adjusted)
            $0.height.equalTo(135.adjusted)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(noSavedArticleImageView.snp.bottom).offset(16.adjusted)
            $0.centerX.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}
