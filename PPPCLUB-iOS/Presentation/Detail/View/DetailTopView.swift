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
    private let gradientImageView = UIImageView()
    lazy var saveButton = UIButton()
    lazy var backButton = UIButton()
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
    lazy var tagCollectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    
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
        shopImageView.do {
            $0.image = Image.mockDetailCard
            $0.backgroundColor = .red
            $0.contentMode = .scaleToFill
        }
        
        gradientImageView.do {
            $0.image = Image.gradient
            $0.contentMode = .scaleToFill
        }
        
        backButton.do {
            $0.setImage(Image.backWhite, for: .normal)
        }
        
        saveButton.do {
            $0.setImage(Image.storeMark, for: .normal)
            $0.setImage(Image.storeMarkFill, for: .selected)
        }
        
        shopNameLabel.do {
            $0.text = "인디페이지 최고"
            $0.font = .pppTitle2
            $0.textColor = .white
        }
        
        addressLabel.do {
            $0.text = "주소"
            $0.font = .pppBody6
            $0.textColor = .white
        }
        
        detailAddressLabel.do {
            $0.text = "상세 주소란"
            $0.font = .pppBody6
            $0.textColor = .white
        }
        
        addressBar.do {
            $0.backgroundColor = .white
        }
        
        runTimeLabel.do {
            $0.text = "운영시간"
            $0.font = .pppBody6
            $0.textColor = .white
        }
        
        runTimeBar.do {
            $0.backgroundColor = .white
        }
        
        detailRunTimeLabel.do {
            $0.text = "Tue-Sat 08:00-19:00"
            $0.font = .pppBody6
            $0.textColor = .white
        }
        
        restLabel.do {
            $0.text = "휴무"
            $0.font = .pppBody6
            $0.textColor = .white
        }
        
        restBar.do {
            $0.backgroundColor = .white
        }
        
        detailRestLabel.do {
            $0.text = "Tue-Sat 08:00-19:00"
            $0.font = .pppBody6
            $0.textColor = .white
        }
        
        tagCollectionView.do {
            $0.backgroundColor = .clear
        }
    }
    
    private func hieararchy() {
        self.addSubviews(shopImageView,
                         gradientImageView,
                         backButton,
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
                         tagCollectionView
        )
    }
    
    private func layout() {
        shopImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gradientImageView.snp.makeConstraints {
            $0.edges.equalTo(shopImageView)
        }
        
        backButton.snp.makeConstraints {
            $0.size.equalTo(42)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(14)
        }
        
        saveButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalToSuperview().inset(28)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.bottom.equalTo(shopImageView).inset(23)
            $0.leading.equalToSuperview().inset(28)
            $0.height.equalTo(34)
            $0.trailing.equalToSuperview()
        }
        
        restLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(28)
            $0.bottom.equalTo(tagCollectionView.snp.top).offset(-8)
        }
        
        restBar.snp.makeConstraints {
            $0.leading.equalTo(restLabel.snp.trailing).offset(4)
            $0.height.equalTo(10)
            $0.width.equalTo(1)
            $0.centerY.equalTo(restLabel)
        }
        
        detailRestLabel.snp.makeConstraints {
            $0.leading.equalTo(restBar.snp.trailing).offset(4)
            $0.centerY.equalTo(restLabel)
        }
        
        runTimeLabel.snp.makeConstraints {
            $0.bottom.equalTo(restLabel.snp.top).offset(-8)
            $0.leading.equalToSuperview().inset(28)
        }
        
        runTimeBar.snp.makeConstraints {
            $0.leading.equalTo(runTimeLabel.snp.trailing).offset(4)
            $0.height.equalTo(10)
            $0.width.equalTo(1)
            $0.centerY.equalTo(runTimeLabel)
        }
        
        detailRunTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(runTimeBar.snp.trailing).offset(4)
            $0.centerY.equalTo(runTimeLabel)
        }
        
        addressLabel.snp.makeConstraints {
            $0.bottom.equalTo(runTimeLabel.snp.top).offset(-6)
            $0.leading.equalToSuperview().inset(28)
        }
        
        addressBar.snp.makeConstraints {
            $0.leading.equalTo(addressLabel.snp.trailing).offset(4)
            $0.height.equalTo(10)
            $0.width.equalTo(1)
            $0.centerY.equalTo(addressLabel)
        }
        
        detailAddressLabel.snp.makeConstraints {
            $0.leading.equalTo(addressBar.snp.trailing).offset(4)
            $0.centerY.equalTo(addressLabel)
        }
        
        shopNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(addressLabel.snp.top).offset(-24)
            $0.leading.equalToSuperview().inset(28)
        }
    }
    
    func dataBind(name: String, address: String, runtime: String, rest: String, imageURL: String) {
        shopNameLabel.text = name
        detailAddressLabel.text = address
        detailRunTimeLabel.text = runtime
        detailRestLabel.text = rest
        shopImageView.kfSetImage(url: imageURL)
    }
}
