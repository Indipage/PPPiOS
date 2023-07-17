//
//  HomeWeeklyView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/14.
//

import UIKit

class HomeWeeklyView: UIView {
    
    // MARK: - UI Components
    
    private let ticketImageView = UIImageView()
    public var ticketCoverImageView = UIImageView()
    private let clearView = UIView()
    private let clearView2 = UIView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
        
//        HomeArticleParsing()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        
        ticketImageView.do {
            $0.image = Image.mockArticleCard
        }
        
        ticketCoverImageView.do {
            $0.image = Image.mockArticleCardPacked
            $0.isUserInteractionEnabled = true
        }
        
        clearView.do {
            $0.backgroundColor = .clear
        }
        
        clearView2.do {
            $0.backgroundColor = .clear
        }
        
    }
    
    private func hierarchy() {
        
        self.addSubviews(ticketImageView, clearView, clearView2,
                         ticketCoverImageView)
        
    }
    
    private func layout() {
        
        ticketImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(40)
        }
        
        ticketCoverImageView.snp.makeConstraints {
            $0.top.equalTo(ticketImageView.snp.top).offset(44)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
        }
        
        clearView.snp.makeConstraints {
            $0.top.equalTo(ticketImageView.snp.top)
            $0.bottom.equalTo(ticketCoverImageView.snp.top)
            $0.width.equalTo(ticketImageView.snp.width)
        }
        
        clearView2.snp.makeConstraints {
            $0.top.equalTo(ticketImageView.snp.top)
            $0.bottom.equalTo(ticketImageView.snp.top).offset(186)
            $0.width.equalTo(ticketImageView.snp.width)
        }
        
    }
}
