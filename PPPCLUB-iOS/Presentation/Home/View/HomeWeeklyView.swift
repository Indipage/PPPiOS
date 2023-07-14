//
//  HomeWeeklyView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/14.
//

import UIKit

class HomeWeeklyView: UIView {

    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let ticketImageView = UIImageView()
    private var ticketCoverImageView = UIImageView()
    private let clearView = UIView()
    private let clearView2 = UIView()
    
    private var gesture : UIPanGestureRecognizer!
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        target()
        
        style()
        hierarchy()
        layout()
        
        print("\(ticketCoverImageView.center.y)\n")
        print("\((ticketCoverImageView.center.y)*87/100)\n")
        
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
    
    @objc private func ticketCaseMoved(_ sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: ticketCoverImageView)
        let changedY = ticketCoverImageView.center.y + transition.y
        
        self.ticketCoverImageView.center = .init(x: ticketCoverImageView.center.x, y: changedY)
        sender.setTranslation(.zero, in: ticketCoverImageView)
        
        checkTicketCasePosition()
    }
    
    private func checkTicketCasePosition() {
        //384 334
         
        if ticketCoverImageView.frame.minY < clearView.frame.maxY  {
            ticketCoverImageView.frame.origin.y = clearView.frame.maxY
        }
        
//        else if (ticketCoverImageView.frame.minY < clearView2.frame.maxY) && (ticketCoverImageView.frame.minY < clearView.frame.maxY) {
//            springAnimation()
//        }
        
        else if ticketCoverImageView.frame.minY > clearView2.frame.maxY {
            ticketCoverImageView.frame.origin.y = clearView2.frame.maxY
            ticketDownAnimation()
            // + 해당 아티클로 넘어가기
        }
    }
    
    private func ticketDownAnimation() {
        UIView.animateKeyframes(withDuration: 0.2, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: {
                self.ticketCoverImageView.frame.origin.y = self.ticketCoverImageView.frame.maxY
            })
        })
    }
    
    private func springAnimation() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
                // CGAffineTransform.identity : 변형을 적용하기 전의 상태로 돌려주는 것
                self.ticketCoverImageView.transform = CGAffineTransform.identity
            }, completion: nil)
    }
}
