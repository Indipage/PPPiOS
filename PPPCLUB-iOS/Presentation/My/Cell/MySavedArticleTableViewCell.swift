//
//  MySavedArticleCollectionView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

//MARK: - SavedArticleCellDelegate

protocol SavedArticleCellDelegate: AnyObject {
    func articleDidTap(articleID: Int?)
}

final class MySavedArticleCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private var articleID: Int?
    weak var delegate: SavedArticleCellDelegate?
    
    //MARK: - UI Components
    
    private let spaceImage = UIButton()
    private let spaceTypeLabel = UIButton()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let ticketReceivedImage = UIImageView()
    private let ticketNotReceivedImage = UIImageView()
    
    //MARK: - Life Cycles
    
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
    
    //MARK: - Custom Method
    
    private func target() {
        spaceImage.addTarget(self, action: #selector(articleButtonDidTap), for: .touchUpInside)
    }
    
    private func cellStyle() {
        contentView.do {
            $0.backgroundColor = .pppGrey2
        }
        
        spaceTypeLabel.do {
            $0.setTitleColor(.pppWhite, for: .normal)
            $0.titleLabel?.font = .pppCaption2
            $0.backgroundColor = .pppMainPurple
            $0.makeCornerRadius(ratio: 5)
        }
        
        titleLabel.do {
            $0.font = .pppSubHead1
            $0.textColor = .pppWhite
        }
        
        subTitleLabel.do {
            $0.font = .pppBody6
            $0.textColor = .pppWhite
            $0.numberOfLines = 0
        }
        
        ticketReceivedImage.do {
            $0.image = Image.ticketReceivedImage
            $0.isHidden = true
        }
        
        ticketNotReceivedImage.do {
            $0.image = Image.ticketNotReceivedImage
            $0.isHidden = true
            $0.makeCornerRadius(ratio: 12)
        }
    }
    
    private func hierarchy() {
        contentView.addSubviews(
            spaceImage,
            spaceTypeLabel,
            titleLabel,
            subTitleLabel,
            ticketReceivedImage,
            ticketNotReceivedImage
        )
    }
    
    private func layout() {
        spaceImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        spaceTypeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(51)
            $0.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.spaceTypeLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(3)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(spaceImage).inset(16)
        }
        
        ticketReceivedImage.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        ticketNotReceivedImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(95)
            $0.height.equalTo(33)
        }
    }
    
    //MARK: - Action Method
    
    @objc func articleButtonDidTap() {
        delegate?.articleDidTap(articleID: articleID)
    }
    
    func dataBind(articleData: MySavedArticleResult) {
        articleID = articleData.id
        spaceTypeLabel.setTitle(articleData.spaceType, for: .normal)
        titleLabel.text = articleData.spaceName
        subTitleLabel.text = articleData.title
        ticketReceivedImage.isHidden = articleData.ticketReceived
        ticketNotReceivedImage.isHidden = !articleData.ticketReceived
        spaceImage.kfSetButtonImage(url: articleData.thumbnailURL, state: .normal)
    }
    
    func dataBindHome(articleData: HomeArticleListResult) {
        articleID = articleData.id
        spaceTypeLabel.setTitle(articleData.spaceType, for: .normal)
        titleLabel.text = articleData.spaceName
        subTitleLabel.text = articleData.title
        ticketReceivedImage.isHidden = articleData.ticketReceived
        ticketNotReceivedImage.isHidden = !articleData.ticketReceived
        spaceImage.kfSetButtonImage(url: articleData.thumbnailURL, state: .normal)
    }
}





