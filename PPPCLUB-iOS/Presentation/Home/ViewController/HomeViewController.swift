//
//  ArticleViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    var viewVelocity = CGPoint(x: 0, y: 0)
    
    private var gesture : UIPanGestureRecognizer!
    
    // MARK: - UI Components
    
    private let rootView = HomeView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        register()
        
        style()
        hierarchy()
        layout()
    }
    
    // MARK: - Custom Method
    
    private func target() {
        
        gesture = UIPanGestureRecognizer(target: self,
                                         action: #selector(ticketCaseMoved(_:)))
        
    }
    
    private func register() {}
    
    private func delegate() {}
    
    private func style() {
        
        rootView.homeWeeklyView.ticketCoverImageView.do {
            $0.addGestureRecognizer(gesture)
        }
        
    }
    
    private func hierarchy() {}
    
    private func layout() {
        
    }
    
    
    //MARK: - Action Method
    
    func presentToArticleViewController() {
        
        let ariticleView = HomeArticleViewController()
        ariticleView.modalPresentationStyle = .fullScreen
        self.present(ariticleView, animated: true)
        
    }
    
    @objc
    public func ticketDragAnimation() {
        
        presentToArticleViewController()
    }
    
    @objc
    private func ticketCaseMoved(_ sender: UIPanGestureRecognizer) {
        
        viewTranslation = sender.translation(in: rootView.homeWeeklyView.ticketCoverImageView)
        viewVelocity = sender.velocity(in: rootView.homeWeeklyView.ticketCoverImageView)
        
        switch sender.state {
            
        case .changed:
            if abs(viewVelocity.y) > abs(viewVelocity.x) {
                
                if viewTranslation.y >= 152 {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.rootView.homeWeeklyView.ticketCoverImageView.transform = CGAffineTransform(translationX: 0, y: 600)
                    }, completion: {_ in
                        UIView.animate(withDuration: 1.0, delay: 3.0) {
                            self.ticketDragAnimation()
                        }
                    })
                }
                
                else if viewVelocity.y > 0 {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.rootView.homeWeeklyView.ticketCoverImageView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                    })
                }
            }
            
        case .ended:
            if viewTranslation.y < 152 {
                UIView.animate(withDuration: 0.04, animations: {
                    self.rootView.homeWeeklyView.ticketCoverImageView.transform = .identity
                })
            }
            else {
                UIView.animate(withDuration: 0.4, animations: {
                    self.rootView.homeWeeklyView.ticketCoverImageView.transform = CGAffineTransform(translationX: 0, y: 600)
                }, completion: {_ in
                    UIView.animate(withDuration: 1.0, delay: 3.0) {
                        self.ticketDragAnimation()
                    }
                })
                
            }
            
        default:
            break
            
        }
    }
}
