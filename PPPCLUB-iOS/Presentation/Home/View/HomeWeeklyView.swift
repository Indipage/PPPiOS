//
//  HomeWeeklyView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/14.
//

import UIKit

class HomeWeeklyView: UIView {
    
    // MARK: - Properties
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    var viewVelocity = CGPoint(x: 0, y: 0)
    
    private var gesture : UIPanGestureRecognizer!
    
    // MARK: - UI Components
    
    private let ticketImageView = UIImageView()
    private var ticketCoverImageView = UIImageView()
    private let clearView = UIView()
    private let clearView2 = UIView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        gesture = UIPanGestureRecognizer(target: self,
                                         action: #selector(ticketCaseMoved(_:)))
        
    }
    
    private func style() {
        
        ticketImageView.do {
            $0.image = Image.mockArticleCard
        }
        
        ticketCoverImageView.do {
            $0.image = Image.mockArticleCardPacked
            $0.addGestureRecognizer(gesture)
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
    
    //MARK: - Action Method
    
    @objc
    private func ticketCaseMoved(_ sender: UIPanGestureRecognizer) {
        
        viewTranslation = sender.translation(in: ticketCoverImageView)
        viewVelocity = sender.velocity(in: ticketCoverImageView)
        
        switch sender.state {
            
        case .changed:
            if abs(viewVelocity.y) > abs(viewVelocity.x) {
                if viewVelocity.y > 0 {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.ticketCoverImageView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                    })
                }
                
                else if viewTranslation.y >= 152 {
                    self.ticketCoverImageView.transform = CGAffineTransform(translationX: 0, y: 600)
                }
            }
            
        case .ended:
            if viewTranslation.y < 152 {
                UIView.animate(withDuration: 0.04, animations: {
                    self.ticketCoverImageView.transform = .identity
                })
            }
            else {
                UIView.animate(withDuration: 0.04, animations: {
                    self.ticketCoverImageView.transform = CGAffineTransform(translationX: 0, y: 600)
                })
            }
            
        default:
            break
            
        }
    }
}
