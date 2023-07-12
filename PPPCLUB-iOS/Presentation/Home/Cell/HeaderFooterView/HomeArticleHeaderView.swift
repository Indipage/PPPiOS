//
//  HomeArticleHeaderView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/12.
//

import UIKit

class HomeArticleHeaderView: UITableViewHeaderFooterView {
    
    
    // MARK: - UI Components
    private var articleImage = UILabel()
    //UIImageView 로 구현해야 함
    
    private var editorLabel = UILabel()
    private var articleTitleLabel = UILabel()
    private var dateLabel = UILabel()
    private var enterStoreButton = UIButton()
    private var divideBarView = UIView()
    
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
        self.backgroundColor = .pppWhite
        articleImage.do {
            $0.backgroundColor = .black
        }
        editorLabel.do {
            $0.text = "책방지기 키위"
            $0.font = .pppCaption1
            $0.textColor = .pppBlack
            $0.textAlignment = .center
        }
        articleTitleLabel.do {
            $0.text = "반복되는 일상 속 나만의\n아지트가 되어주는 공간"
            $0.font = .pppSubHead1
            $0.textColor = .pppBlack
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.setLineSpacing(spacing: 7)
        }
        dateLabel.do {
            $0.text = "2023-06-08"
            $0.font = .pppCaption2
            $0.textColor = .pppBlack
            $0.textAlignment = .center
        }
        enterStoreButton.do {
            $0.setImage( Image.mockEnterBookStore, for: .normal)
        }
        divideBarView.do {
            $0.backgroundColor = .pppGrey2
        }
        
    }
    
    private func hierarchy() {
        self.addSubviews(articleImage,
                         editorLabel,
                         articleTitleLabel,
                         dateLabel,
                         enterStoreButton,
                         divideBarView
        )
    }
    
    private func layout() {
        articleImage.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(228)
            $0.top.equalToSuperview()
        }
        
        editorLabel.snp.makeConstraints {
            $0.bottom.equalTo(articleTitleLabel.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        articleTitleLabel.snp.makeConstraints {
            $0.top.equalTo(articleImage.snp.bottom).offset(37)
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(articleTitleLabel.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
        }
        
        enterStoreButton.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.width.equalToSuperview()
        }
        
        divideBarView.snp.makeConstraints {
            $0.top.equalTo(enterStoreButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

