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
        
        uniqueImageView.do {
            $0.image = Image.uniqueCard
            $0.backgroundColor = .systemPink
        }
    }
    
    private func hieararchy() {
        self.addSubviews(uniqueLabel,
                         uniqueImageView
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
            $0.height.equalTo(234.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
