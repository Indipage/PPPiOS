//
//  WeeklyCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/21.
//

import UIKit

import SnapKit
import Then
    
protocol ThisWeekCellDelegate: AnyObject {
    func thisWeekCardImageDidTap(articleID: Int?)
}

final class ThisWeekCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var articleID: Int?
    weak var delegate: ThisWeekCellDelegate?
    
    // MARK: - UI Components
    
    lazy var thisWeekCardImage = UIButton()
    var cardTitleLabel = UILabel()
    var cardStoreNameLabel = UILabel()
    var cardStoreOwnerLabel = UILabel()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        target()
        
        cellStyle()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func target() {
        thisWeekCardImage.addTarget(self, action: #selector(thisWeekCardImageDidTap), for: .touchUpInside)
    }
    
    private func cellStyle() {
        
        thisWeekCardImage.do {
            $0.backgroundColor = .pppBlack
        }
        cardTitleLabel.do {
            $0.font = .pppTitle1
            $0.textColor = .pppWhite
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.setLineSpacing(spacing: 9)
        }
        cardStoreNameLabel.do {
            $0.font = .pppTitle2
            $0.textColor = .pppMainLightGreen
            $0.textAlignment = .right
        }
        cardStoreOwnerLabel.do {
            $0.font = .pppBody5
            $0.textColor = .pppMainLightGreen
            $0.textAlignment = .right
        }
    }
    
    private func hierarchy() {
        self.addSubview(thisWeekCardImage)
        thisWeekCardImage.addSubviews(cardTitleLabel, cardStoreNameLabel, cardStoreOwnerLabel, cardStoreNameLabel)
    }
    
    private func layout() {
        
        thisWeekCardImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
        }
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalToSuperview()
        }
        cardStoreNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(cardStoreOwnerLabel.snp.top).offset(-6)
            $0.trailing.equalTo(cardStoreOwnerLabel.snp.trailing)
        }
        cardStoreOwnerLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(36)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
    
    func configureCell(articleData: HomeArticleCardResult?) {
        guard let articleData = articleData else { return }
        self.articleID = articleData.id
        thisWeekCardImage.kfSetButtonImage(url: articleData.thumbnailUrlOfThisWeek, state: .normal)
        cardTitleLabel.text = articleData.title
        cardStoreNameLabel.text = articleData.spaceName
        cardStoreOwnerLabel.text = articleData.spaceOwner
    }
    
    @objc func thisWeekCardImageDidTap() {
        delegate?.thisWeekCardImageDidTap(articleID: articleID)
    }
}

class NextWeekCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    var nextWeekCardImage = UIImageView()
    var cardGradient = UIImageView()
    var afterLabel = UILabel()
    var remainingLabel = UILabel()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellStyle()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func cellStyle() {
        
        nextWeekCardImage.do {
            $0.backgroundColor = .pppMainLightGreen
        }
        
        cardGradient.do {
            $0.image = Image.articleTicketGradient
        }
        
        afterLabel.do {
            $0.text = "After"
            $0.font = .pppEnTitle2
            $0.textColor = .pppMainLightGreen
        }
        
        remainingLabel.do {
            $0.font = .pppEnTitle1
            $0.textColor = .pppMainLightGreen
        }
    }
    
    private func hierarchy() {
        self.addSubview(nextWeekCardImage)
        nextWeekCardImage.addSubviews(cardGradient,afterLabel, remainingLabel)
    }
    
    private func layout() {
        
        nextWeekCardImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cardGradient.snp.makeConstraints {
            $0.edges.equalTo(nextWeekCardImage.snp.edges)
        }
        
        afterLabel.snp.makeConstraints {
            $0.bottom.equalTo(remainingLabel.snp.top)
            $0.trailing.equalTo(remainingLabel.snp.trailing)
        }
        
        remainingLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(36)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
    
    func configureCell(articleData: HomeArticleCardResult?) {
        guard let articleData = articleData else { return }
        nextWeekCardImage.kfSetImage(url: articleData.thumbnailUrlOfNextWeek)
        var remainingInt = articleData.remainingDays
        remainingLabel.text = "\(remainingInt)Days"
    }
    
}
