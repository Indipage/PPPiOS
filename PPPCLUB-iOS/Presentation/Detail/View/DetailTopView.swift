//
//  DetailView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class DetailTopView: UIView {
    
    // MARK: - UI Components
    
    private let shopImageView = UIImageView()
    private lazy var saveButton = UIButton()
    private lazy var shopNameLabel = UILabel()
    private let addressLabel = UILabel()
    private lazy var detailAddressLabel = UILabel()
    private let addressBar = UIView()
    private let runTimeLabel = UILabel()
    private let runTimeBar = UIView()
    private lazy var detailRunTimeLabel = UILabel()
    private let restLabel = UILabel()
    private let restBar = UIView()
    private lazy var detailRestLabel = UILabel()
    private lazy var tagCollectionView = UICollectionView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        
        shopImageView.do {
            $0.backgroundColor = .red
            $0.contentMode = .scaleAspectFill
        }
        
        saveButton.do {
            $0.backgroundColor = .blue
        }
        
        shopNameLabel.do {
            $0.text = "인디페이지 최고"
            $0.font = .pppTitle1
            $0.textColor = .white
        }
        
        addressLabel.do {
            $0.text = "주소"
            $0.font = .pppCaption1
            $0.textColor = .white
        }
        
        detailAddressLabel.do {
            $0.text = "상세 주소란"
            $0.font = .pppCaption1
            $0.textColor = .white
        }
        
        addressBar.do {
            $0.backgroundColor = .white
        }
        
        runTimeLabel.do {
            $0.text = "운영시간"
            $0.font = .pppCaption1
            $0.textColor = .white
        }
        
        runTimeBar.do {
            $0.backgroundColor = .white
        }
        
        detailRunTimeLabel.do {
            $0.text = "Tue-Sat 08:00-19:00"
            $0.font = .pppCaption1
            $0.textColor = .white
        }
        
        restLabel.do {
            $0.text = "휴무"
            $0.font = .pppCaption1
            $0.textColor = .white
        }
        
        restBar.do {
            $0.backgroundColor = .white
        }
        
        detailRestLabel.do {
            $0.text = "Tue-Sat 08:00-19:00"
            $0.font = .pppCaption1
            $0.textColor = .white
        }
    }
    
    private func hieararchy() {
        self.addSubviews(shopImageView,
                         saveButton,
                         shopNameLabel,
                         addressLabel,
                         detailAddressLabel,
                         addressBar,
                         runTimeLabel,
                         runTimeBar,
                         detailRunTimeLabel,
                         restLabel,
                         restBar,
                         detailRestLabel,
                         tagCollectionView)
    }
    
    private func layout() {
        
        shopImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(381 / 812)
            $0.width.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints {
            $0.width.equalTo(25)
            $0.height.equalTo(31)
            $0.top.trailing.equalToSuperview().inset(30)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.bottom.equalTo(shopImageView).inset(23)
            $0.leading.equalToSuperview().inset(21)
        }
        
        restLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(23)
            $0.bottom.equalTo(tagCollectionView.snp.top).offset(-8)
        }
        
        restBar.snp.makeConstraints {
            $0.leading.equalTo(restLabel.snp.trailing).offset(3)
            $0.height.equalTo(restLabel)
            $0.width.equalTo(1)
            $0.centerY.equalTo(restLabel)
        }
        
        detailRestLabel.snp.makeConstraints {
            $0.leading.equalTo(restBar.snp.trailing).offset(3)
            $0.centerY.equalTo(restLabel)
        }
        
        runTimeLabel.snp.makeConstraints {
            $0.bottom.equalTo(restLabel.snp.top).offset(8)
            $0.leading.equalToSuperview().inset(23)
        }
        
        runTimeBar.snp.makeConstraints {
            $0.leading.equalTo(runTimeLabel.snp.trailing).offset(-3)
            $0.height.equalTo(runTimeLabel)
            $0.width.equalTo(1)
            $0.centerY.equalTo(runTimeLabel)
        }
        
        detailRunTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(runTimeBar.snp.trailing).offset(3)
            $0.centerY.equalTo(runTimeLabel)
        }
        
        addressLabel.snp.makeConstraints {
            $0.bottom.equalTo(runTimeLabel.snp.top).offset(-20)
            $0.leading.equalToSuperview().inset(23)
        }
        
        addressBar.snp.makeConstraints {
            $0.leading.equalTo(addressLabel.snp.trailing).offset(-3)
            $0.height.equalTo(addressLabel)
            $0.width.equalTo(1)
            $0.centerY.equalTo(addressLabel)
        }
        
        detailAddressLabel.snp.makeConstraints {
            $0.leading.equalTo(addressBar.snp.trailing).offset(3)
            $0.centerY.equalTo(addressLabel)
        }
        
        shopNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(addressLabel.snp.top).offset(-8)
            $0.leading.equalToSuperview().inset(23)
        }
    }
}
