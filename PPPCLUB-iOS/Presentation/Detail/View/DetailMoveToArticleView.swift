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
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let placeLabel = UILabel()
    private lazy var shopImageButton = UIButton()
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
            $0.font = .pppTitle1
            $0.textColor = .black
        }
        
        shopImageButton.do {
            $0.setImage(UIImage(systemName: "pencil"), for: .normal)
            $0.layer.cornerRadius = 10
//            $0.backgroundColor = .pppMainPink
        }
        
        goReadButton.do {
            $0.setTitle("읽으러 가기 >", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 12
            $0.titleLabel?.font = .pppCaption2
        }
    }
    
    private func hierarchy() {
        self.addSubviews(placeLabel,
                         shopImageButton,
                         goReadButton
        )
    }
    
    private func layout() {
        placeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
            $0.height.equalTo(21)
        }
        
        shopImageButton.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(10)
            $0.height.equalTo(180)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        goReadButton.snp.makeConstraints {
            $0.height.equalTo(33)
            $0.width.equalTo(95)
            $0.trailing.equalTo(shopImageButton).inset(16)
            $0.bottom.equalTo(shopImageButton).inset(12)
        }
    }
}
