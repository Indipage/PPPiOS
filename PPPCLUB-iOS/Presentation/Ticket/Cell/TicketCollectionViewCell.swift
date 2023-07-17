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
    func ticketImageDidSwapped(spaceID: Int)
}

final class TicketCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var delegate: TicketDelegate?
    private var point: CGPoint = CGPoint(x: 0, y: 0)
    private var ticketID: Int?
    private var spaceID: Int?
    
    //MARK: - UI Components
    
    private let ticketImageView = UIButton()
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
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
        let translation = recognizer.translation(in: ticketImageView)
        ticketImageView.center = CGPoint(
            x: ticketImageView.center.x + translation.x,
            y: ticketImageView.center.y
        )
        
        recognizer.setTranslation(CGPoint.zero, in: ticketImageView)
        var velocity = recognizer.velocity(in: ticketImageView)
        switch recognizer.state {
        case .began:
            if velocity.x > 0 { recognizer.state = .cancelled }
        case .changed:
            if velocity.x > 0 { self.ticketImageView.center.x = self.point.x-55 }
        case .ended:
            if ticketImageView.center.x + translation.x < 35 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.ticketImageView.center.x = self.point.x-55
                }) { _ in
                    self.delegate?.ticketImageDidSwapped(spaceID: self.spaceID!)
                }
                
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.ticketImageView.center.x = self.point.x-55
                })
            }
        @unknown default:
            break
        }
    }
}

//MARK: - TicketCollectionViewCell

extension TicketCollectionViewCell {
    func configureCell(ticket: TicketResult, point: CGPoint) {
        self.point = point
        self.ticketID = ticket.ticketID
        self.spaceID = ticket.spaceID
        ticketImageView.kfSetButtonImage(url: ticket.imageURL)
    }
}
