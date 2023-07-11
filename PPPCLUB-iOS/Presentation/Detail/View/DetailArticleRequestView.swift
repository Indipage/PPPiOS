//
//  DetailArticleRequestView.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class DetailArticleRequestView: UIView {
        
    // MARK: - UI Components
    
    private let placeLabel = UILabel()
    private let noticeLabel = UILabel()
    private lazy var requestButton = UIButton()
    
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
        placeLabel.do {
            $0.text = "공간 이야기"
            $0.font = .pppTitle1
            $0.textColor = .black
        }
        
        noticeLabel.do {
            $0.text = "인디페이지에서 서점이야기를 준비 중이에요.\n빠른 소식을 원한다면 아래 ‘조르기’ 버튼을 눌러주세요:)"
            $0.font = .pppCaption2
            $0.textColor = .pppGrey2
            $0.numberOfLines = 3
        }
        
        requestButton.do {
            $0.setTitle("조르기", for: .normal)
            $0.setTitle("조르기 완료!", for: .selected)
            $0.setTitleColor(.black, for: .normal)
            $0.setTitleColor(.white, for: .selected)
            $0.backgroundColor = .systemYellow
        }
    }
    
    private func hieararchy() {
        self.addSubviews(placeLabel,
                         noticeLabel,
                         requestButton
        )
    }
    
    private func layout() {
        placeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
            $0.height.equalTo(21)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(36)
        }
        
        requestButton.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(59)
        }
    }
}
