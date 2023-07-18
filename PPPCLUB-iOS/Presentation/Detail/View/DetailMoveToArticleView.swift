//
//  DetailMoveToArticleView.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class DetailMoveToArticleView: UIView {

    // MARK: - UI Components
    
    private let placeLabel = UILabel()
    private let spaceTypeLabel = UILabel()
    private let frontEmptyLabel = UILabel()
    private let backEmptyLabel = UILabel()
    private lazy var spaceTypeStackView = UIStackView(arrangedSubviews: [frontEmptyLabel,
                                                                         spaceTypeLabel,
                                                                         backEmptyLabel]
    )
    private var spaceNameLabel = UILabel()
    private var titleLabel = UILabel()
    private lazy var shopImageView = UIImageView()
    private lazy var goReadButton = UIButton()

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
    
    private func style() {
        placeLabel.do {
            $0.text = "공간 이야기"
            $0.font = .pppSubHead1
            $0.textColor = .black
        }
        
        spaceTypeLabel.do {
            $0.text = "독립서점"
            $0.font = .pppCaption2
            $0.textColor = .pppWhite
            $0.textAlignment = .center
            $0.frame.size = $0.intrinsicContentSize
        }
        
        spaceTypeStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
            $0.layer.cornerRadius = 5
            $0.layer.backgroundColor = UIColor.pppMainPurple.cgColor
        }
        
        spaceNameLabel.do {
            $0.text = "문학살롱 초고"
            $0.font = .pppSubHead1
            $0.textColor = .pppWhite
        }
        
        titleLabel.do {
            $0.text = "반복되는 일상 속 나만의 아지트가 되어주는 공간"
            $0.font = .pppBody6
            $0.textColor = .pppWhite
            $0.numberOfLines = 0
        }
        
        shopImageView.do {
            $0.image = Image.mockArticle
            $0.contentMode = .scaleToFill
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .pppMainLightGreen
        }
        
        goReadButton.do {
            $0.setTitle("읽으러 가기 >", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 12
            $0.titleLabel?.font = .pppCaption1
        }
    }
    
    private func hierarchy() {
        self.addSubviews(placeLabel,
                         shopImageView,
                         spaceTypeStackView,
                         spaceNameLabel,
                         titleLabel,
                         goReadButton
        )
    }
    
    private func layout() {
        placeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
            $0.height.equalTo(28)
        }
        
        shopImageView.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(8)
            $0.height.equalTo(180)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        spaceTypeLabel.snp.makeConstraints {
            $0.height.equalTo(22)
        }
        
        frontEmptyLabel.snp.makeConstraints {
            $0.width.equalTo(8)
        }
        
        backEmptyLabel.snp.makeConstraints {
            $0.width.equalTo(8)
        }
        
        spaceTypeStackView.snp.makeConstraints {
            $0.top.equalTo(shopImageView).offset(22)
            $0.leading.equalTo(shopImageView).inset(16)
            $0.height.equalTo(22)
        }
        
        spaceNameLabel.snp.makeConstraints {
            $0.top.equalTo(spaceTypeStackView.snp.bottom).offset(8)
            $0.leading.equalTo(spaceTypeStackView)
            $0.height.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(spaceNameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(spaceTypeStackView)
            $0.trailing.equalTo(spaceNameLabel).inset(16)
            $0.height.equalTo(18)
        }
        
        goReadButton.snp.makeConstraints {
            $0.height.equalTo(33)
            $0.width.equalTo(95)
            $0.trailing.equalTo(shopImageView).inset(16)
            $0.bottom.equalTo(shopImageView).inset(12)
        }
    }
    
    func dataBind(result: DetailCheckArticleResult) {
        spaceNameLabel.text = result.spaceName
        titleLabel.text = result.title
        spaceTypeLabel.text = result.spaceType
        shopImageView.kfSetImage(url: result.imageUrl)
    }
}
