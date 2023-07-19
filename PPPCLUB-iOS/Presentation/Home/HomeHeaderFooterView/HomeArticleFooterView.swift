//
//  HomeArticleFooterView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

class HomeArticleFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    var ticketID = Int()
    var ticketURL = String()
    var cardURL = String()
    var ticketReceived = Bool()
    
    // MARK: - UI Components
    
    var divideBarView = UIView()
    var ticketTitleLabel = UILabel()
    var ticketSubLabel = UILabel()
    var ticketImageView = UIImageView()
    
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
        
        ticketTitleLabel.do {
            $0.text = "티켓 받아가세요!"
            $0.font = .systemFont(ofSize: 20)
            $0.textColor = .pppBlack
            $0.textAlignment = .center
        }
        
        ticketSubLabel.do {
            $0.text = "이번 주 아티클은 잘 읽으셨나요?\nPPPclub에서 드리는 티켓을 가지고\n문학살롱 초고에 방문하여 인증받아보세요!"
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .pppBlack
            $0.setLineSpacing(spacing: 10)
            $0.numberOfLines = 3
            $0.textAlignment = .center
        }
        
        ticketImageView.do {
            $0.backgroundColor = .white
            $0.image = Image.mockDetailCard
        }
        
    }
    
    private func hierarchy() {
        
        self.addSubviews(divideBarView,
                         ticketImageView,
                         ticketTitleLabel,
                         ticketSubLabel
        )
    }
    
    private func layout() {
        
        divideBarView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        ticketTitleLabel.snp.makeConstraints {
            $0.top.equalTo(divideBarView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        ticketSubLabel.snp.makeConstraints {
            $0.top.equalTo(ticketTitleLabel.snp.bottom).offset(27)
            $0.centerX.equalToSuperview()
        }
        
        ticketImageView.snp.makeConstraints {
            $0.top.equalTo(ticketSubLabel.snp.bottom).offset(27)
            $0.leading.equalToSuperview().inset(89)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(91)
        }
        
    }
    
    //MARK: - Action Method
    
    func dataBindTicketCheck(articleData: HomeTicketCheckResult?) {
        guard let articleData = articleData else { return }

        ticketID = articleData.ticket.id
        ticketURL = articleData.ticket.ticketImageURL
        cardURL = articleData.ticket.cardImageURL
        ticketReceived = articleData.hasReceivedTicket
        
        ticketImageView.kfSetImage(url: ticketURL)
    }
}
