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
    var ticketButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        target()
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func target() {
        ticketButton.addAction(UIAction(handler: { action in
            self.ticketButtonDidTap(image: self.ticketURL)
        }), for: .touchUpInside)
    }
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
            $0.text = ""
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .pppBlack
            $0.setLineSpacing(spacing: 10)
            $0.numberOfLines = 3
            $0.textAlignment = .center
        }
        
        ticketButton.do {
            $0.setImage(Image.mockNoTicket, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFill
            $0.addTarget(self, action: #selector(ticketButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func hierarchy() {
        
        contentView.addSubviews(ticketButton,
                                divideBarView,
                                ticketTitleLabel,
                                ticketSubLabel)
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
        
        ticketButton.snp.makeConstraints {
            $0.top.equalTo(ticketSubLabel.snp.bottom).offset(27)
            $0.leading.equalToSuperview().inset(89)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(383)
            $0.bottom.equalToSuperview().inset(91)
        }
    }
    
    //MARK: - Action Method
    @objc func ticketButtonDidTap(image: String) {
        ticketButton.kfSetButtonImage(url: image, state: .normal)
        showToast()
    }
    
    func dataBindTicketCheck(articleData: HomeTicketCheckResult?) {
        guard let articleData = articleData else { return }
        
        ticketID = articleData.ticket.id
        ticketURL = articleData.ticket.ticketForArticleImageURL
        cardURL = articleData.ticket.cardImageURL
        ticketReceived = articleData.hasReceivedTicket
        
        if !ticketReceived {
            ticketButton.setImage(Image.mockNoTicket, for: .normal)
        }
        else {
            ticketButton.kfSetButtonImage(url: ticketURL, state: .disabled)
            ticketButton.isEnabled = false
        }
    }
    
    func dataBindTicketCheck2(articleData: HomeDetailArticleResult?) {
        guard let articleData = articleData else { return }
        ticketSubLabel.text = "이번 주 아티클은 잘 읽으셨나요?\nPPPclub에서 드리는 티켓을 가지고\n\(articleData.spaceName)에 방문하여 인증받아보세요!"
    }
    
    public func showToast() {
        let toastView = PPPToastMessage()
        toastView.layer.cornerRadius = 6
        toastView.toastButton.isEnabled = true
        
        self.addSubview(toastView)
        
        toastView.snp.makeConstraints() {
            $0.bottom.equalToSuperview().inset(46)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(28)
            $0.height.equalTo(54)
        }
        
        
        UIView.animate(withDuration: 1.0, delay: 4.0, options: .curveEaseIn) {
            toastView.alpha = 0.0
        } completion: { _ in
            toastView.removeFromSuperview()
        }
    }
}

