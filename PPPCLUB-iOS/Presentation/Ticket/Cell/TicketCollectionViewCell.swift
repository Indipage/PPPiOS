//
//  TicketCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

//MARK: - TicketDelegate

protocol TicketDelegate: AnyObject {
    func ticketImageDidSwapped(spaceID: Int?)
}

final class TicketCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private var animationManager: AnimationManager
    
    weak var delegate: TicketDelegate?
    private var point: CGPoint = CGPoint(x: 0, y: 0)
    private var ticketID: Int?
    private var spaceID: Int?
    
    //MARK: - UI Components
    
    private let ticketImageView = UIButton()
    
    //MARK: - Life Cycles
    
    init(frame: CGRect, animationManager: AnimationManager) {
        self.animationManager = animationManager
        super.init(frame: frame)
        
        gesture()
        
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func gesture() {
        lazy var panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(ticketGestureHandler))
        self.ticketImageView.addGestureRecognizer(panGesture)
    }
    
    private func hierarchy() {
        contentView.addSubview(ticketImageView)
    }
    
    private func layout() {
        ticketImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(55)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    //MARK: - Action Method
    
    @objc func ticketGestureHandler(recognizer: UIPanGestureRecognizer) {
        animationManager.ticketAnimate(
            point: point,
            targetView: ticketImageView,
            recoginizer: recognizer
        ) { _ in
            self.delegate?.ticketImageDidSwapped(spaceID: self.spaceID)
        }
    }
}


//MARK: - TicketCollectionViewCell

extension TicketCollectionViewCell {
    func configureCell(ticket: TicketResult, point: CGPoint) {
        self.point = point
        self.ticketID = ticket.ticketID
        self.spaceID = ticket.spaceID
        ticketImageView.kfSetButtonImage(url: ticket.imageURL, state: .normal)
    }
}
