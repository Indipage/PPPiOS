//
//  HomeArticleFooterView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/12.
//

import UIKit

class HomeArticleFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    private var divideBarView = UIView()
    private var getTitleLabel = UILabel()
    private var getSubLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        
        self.backgroundColor = .pppWhite
        
        divideBarView.do {
            $0.backgroundColor = .pppGrey2
        }
        getTitleLabel.do {
            $0.text = "티켓 받아가세요!"
            $0.font = .systemFont(ofSize: 20)
            $0.textColor = .pppBlack
            $0.textAlignment = .center
        }
        getSubLabel.do {
            $0.text = "이번 주 아티클은 잘 읽으셨나요?\nPPPclub에서 드리는 티켓을 가지고\n문학살롱 초고에 방문하여 인증받아보세요!"
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .pppBlack
            $0.textAlignment = .center
            $0.setLineSpacing(spacing: 10)
            $0.numberOfLines = 3
        }
    }
    
    private func hierarchy() {
        self.addSubviews(divideBarView,
                         getTitleLabel,
                         getSubLabel
        )
    }
    
    private func layout() {
        divideBarView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        getTitleLabel.snp.makeConstraints {
            $0.top.equalTo(divideBarView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        getSubLabel.snp.makeConstraints {
            $0.top.equalTo(getTitleLabel.snp.bottom).offset(27)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(544)
        }
    }
    
}
