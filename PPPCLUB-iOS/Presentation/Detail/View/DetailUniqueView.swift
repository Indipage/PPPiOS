//
//  DetailUniqueView.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class DetailUniqueView: UIView {
        
    // MARK: - UI Components
    
    private let uniqueLabel = UILabel()
    private let peculiarityTitleLabel = UILabel()
    private let peculiarityContentLabel = UILabel()
    private lazy var uniqueImageView = UIImageView()
    
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
        uniqueLabel.do {
            $0.text = "특색 요소"
            $0.font = .pppSubHead1
            $0.textColor = .black
        }
        
        peculiarityTitleLabel.do {
            $0.text = "문학 칵테일"
            $0.font = .pppSubHead1
            $0.textColor = .pppWhite
            $0.textAlignment = .right
        }
        
        peculiarityContentLabel.do {
            $0.text = "문학 작품과 즐기는 칵테일,\n이런 고급스러운 취미는 어때요?"
            $0.numberOfLines = 0
            $0.font = .pppBody4
            $0.textColor = .pppWhite
            $0.textAlignment = .right
        }
        
        uniqueImageView.do {
            $0.image = Image.uniqueCard
            $0.backgroundColor = .systemPink
        }
    }
    
    private func hieararchy() {
        self.addSubviews(uniqueLabel,
                         uniqueImageView,
                         peculiarityTitleLabel,
                         peculiarityContentLabel
        )
    }
    
    private func layout() {
        uniqueLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
            $0.height.equalTo(28)
        }
        
        uniqueImageView.snp.makeConstraints {
            $0.top.equalTo(uniqueLabel.snp.bottom).offset(10)
            $0.height.equalTo(234)
            $0.leading.trailing.equalToSuperview()
        }
        
        peculiarityContentLabel.snp.makeConstraints {
            $0.bottom.equalTo(uniqueImageView).inset(24)
            $0.leading.trailing.equalTo(uniqueImageView).inset(28)
        }
        
        peculiarityTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(peculiarityContentLabel.snp.top).offset(-8)
            $0.trailing.equalTo(uniqueImageView).inset(28)
            $0.height.equalTo(28)
        }
    }
}
