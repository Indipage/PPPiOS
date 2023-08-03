//
//  HomeArticleHeaderView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

protocol ArticleHeaderViewDelegate: AnyObject {
    func enterStoreButtonDidTap()
}

class HomeArticleHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    
    weak var delegate: ArticleHeaderViewDelegate?
    
    // MARK: - UI Components
    
    private var articleImage = UIImageView()
    
    private let enterDetailView = UIView()
    private let enterDetailTitleLabel = UILabel()
    private let enterSpaceLabel = UILabel()
    private let enterSpaceArrow = UIImageView()
    private let enterDetailSubTitleLabel = UILabel()
    
    private var editorLabel = UILabel()
    private var articleTitleLabel = UILabel()
    private var dateLabel = UILabel()
    private var divideBarView = UIView()
    
    // MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        gesture()
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func gesture() {
        lazy var enterStoreButtonGesture = UITapGestureRecognizer.init(target: self, action: #selector(enterStoreButtonGestureHandler))
        
        self.enterDetailView.addGestureRecognizer(enterStoreButtonGesture)
    }
    
    private func style() {
        
        self.backgroundColor = .pppWhite
        
        articleImage.do {
            $0.backgroundColor = .black
        }
        
        editorLabel.do {
            $0.font = .pppCaption1
            $0.textColor = .pppBlack
            $0.textAlignment = .center
            $0.setLineSpacing(spacing: 5)
        }
        
        articleTitleLabel.do {
            $0.font = .pppSubHead1
            $0.textColor = .pppBlack
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.setLineSpacing(spacing: 7)
        }
        
        dateLabel.do {
            $0.font = .pppCaption2
            $0.textColor = .pppBlack
            $0.textAlignment = .center
        }
        
        enterDetailView.do {
            $0.backgroundColor = .pppBlack
        }
        
        enterDetailTitleLabel.do {
            $0.text = "나만 알고싶은"
            $0.textColor = .pppMainLightGreen
            $0.font = .pppCaption1
        }
        
        enterSpaceLabel.do {
            $0.textColor = .pppMainLightGreen
            $0.font = .pppBody3
        }
        
        enterDetailSubTitleLabel.do {
            $0.textColor = .pppMainLightGreen
            $0.font = .pppBody3
            $0.text = "바로가기"
        }
        
        enterSpaceArrow.do {
            $0.image = Image.articleArrow
        }
        
        divideBarView.do {
            $0.backgroundColor = .pppGrey2
        }
        
    }
    
    private func hierarchy() {
        
        contentView.addSubviews(articleImage,
                         editorLabel,
                         articleTitleLabel,
                         dateLabel,
                        enterDetailView,
                         divideBarView)
        
        enterDetailView.addSubviews(
            enterDetailTitleLabel,
            enterSpaceLabel,
            enterDetailSubTitleLabel,
            enterSpaceArrow
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
            $0.leading.equalToSuperview().offset(91)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(articleTitleLabel.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
        }
        
        enterDetailView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.width.equalToSuperview()
            $0.height.equalTo(103)
        }
        
        divideBarView.snp.makeConstraints {
            $0.top.equalTo(enterDetailView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(1)
        }
        
        enterDetailTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(28)
        }
        enterSpaceLabel.snp.makeConstraints {
            $0.top.equalTo(self.enterDetailTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(self.enterDetailTitleLabel)
        }
        
        enterDetailSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.enterSpaceLabel.snp.bottom).offset(2)
            $0.leading.equalTo(self.enterDetailTitleLabel)
        }
        enterSpaceArrow.snp.makeConstraints {
            $0.top.equalToSuperview().offset(62)
            $0.trailing.equalToSuperview().inset(28)
        }
    }
    
    //MARK: - Action Method
    
    @objc func enterStoreButtonGestureHandler() {
        delegate?.enterStoreButtonDidTap()
    }
}

extension HomeArticleHeaderView {
    func dataBind(articleData: HomeDetailArticleResult?) {
        guard let articleData = articleData else { return }
        enterSpaceLabel.text = articleData.spaceName
        articleTitleLabel.text = articleData.title
        editorLabel.text = articleData.spaceOwner
        dateLabel.text = articleData.issueDate
        articleImage.kfSetImage(url: articleData.thumbnailURL)
    }
}

