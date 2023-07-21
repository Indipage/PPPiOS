//
//  HomeWeeklyView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/14.
//

import UIKit

class HomeWeeklyView: UIView {
    
    var cardId = Int()
    var slideCheck = Bool()
    
    // MARK: - UI Components
    
    var thisWeekCardImage = UIImageView()
    var nextWeekCardImage = UIImageView()
    var cardTitleLabel = UILabel()
    var cardStoreNameLabel = UILabel()
    var cardStoreOwnerLabel = UILabel()
    var ticketCoverImageView = UIImageView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        hierarchy()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        
        cardTitleLabel.do {
            $0.text = "바보"
            $0.font = .pppTitle1
            $0.textColor = .pppWhite
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }
        
        cardStoreOwnerLabel.do {
            $0.text = "바보"
            $0.font = .pppBody5
            $0.textColor = .pppMainLightGreen
            $0.textAlignment = .right
        }
        cardStoreNameLabel.do {
            $0.text = "바보"
            $0.font = .pppTitle2
            $0.textColor = .pppMainLightGreen
            $0.textAlignment = .right
        }
        
        ticketCoverImageView.do {
            $0.image = Image.mockArticleCardPacked
            $0.isUserInteractionEnabled = true
            $0.isHidden = true
        }
        
    }
    
    private func hierarchy() {
        self.addSubviews(thisWeekCardImage, nextWeekCardImage, ticketCoverImageView)
        thisWeekCardImage.addSubviews(cardTitleLabel, cardStoreNameLabel, cardStoreOwnerLabel)
    }
    
    private func layout() {
        
        thisWeekCardImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(295.adjusted)
            $0.height.equalTo(472.adjusted)
        }
        
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(thisWeekCardImage)
        }
        
        cardStoreOwnerLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(36)
            $0.trailing.equalToSuperview().inset(24)
        }
        cardStoreNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(cardStoreOwnerLabel.snp.top).offset(-6)
            $0.trailing.equalTo(cardStoreOwnerLabel.snp.trailing)
        }
        
        ticketCoverImageView.snp.makeConstraints {
            $0.top.equalTo(thisWeekCardImage.snp.top).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(319.adjusted)
            $0.height.equalTo(486.adjusted)
        }
    }
}

extension HomeWeeklyView {
    func dataBindArticleCard(articleData: HomeArticleCardResult?) {
        guard let articleData = articleData else { return }
        cardId = articleData.id
        thisWeekCardImage.kfSetImage(url: articleData.thumbnailUrlOfThisWeek)
        nextWeekCardImage.kfSetImage(url: articleData.thumbnailUrlOfNextWeek)
        cardTitleLabel.text = articleData.title
        cardStoreNameLabel.text = articleData.spaceName
        cardStoreOwnerLabel.text = articleData.spaceOwner
//        cardRemainingDayLabel.text = String(articleData.remainingDays)
    }
    
    func dataBindArticleSlideCheck(articleData: HomeArticleCheckResult?) {
        print("😵‍💫실행됨")
        guard let hasSlide = articleData?.hasSlide else { return }
        ticketCoverImageView.isHidden = false
    }
}
