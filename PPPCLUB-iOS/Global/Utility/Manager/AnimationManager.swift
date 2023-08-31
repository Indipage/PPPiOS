//
//  AnimationManager.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/21.
//

import UIKit

class AnimationManager {
    static let shared = AnimationManager()
    
    init() {}
    
    func ticketToggleButtonAnimate(
        targetView: UIView,
        translationX: CGFloat?,
        selectedLabel: UILabel,
        unSelectedLable: UILabel
    ) {
        
        print("translationX: \(String(describing: translationX))")
        let transform: CGAffineTransform
        if let translationX {
            transform = CGAffineTransform(translationX: translationX, y: 0)
        } else {
            transform = .identity
        }
        let selectedTextColor: UIColor = .pppWhite
        let unSelectedTextColor: UIColor = .pppGrey4
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                targetView.transform = transform
                selectedLabel.textColor = selectedTextColor
                unSelectedLable.textColor = unSelectedTextColor
            })
    }
    
    func ticketAnimate(
        point: CGPoint,
        targetView: UIView,
        recoginizer: UIPanGestureRecognizer,
        completion: (((Bool) -> Void)?)
    ) {
        let translation = recoginizer.translation(in: targetView)
        targetView.center = CGPoint(
            x: targetView.center.x + translation.x,
            y: targetView.center.y
        )
        
        recoginizer.setTranslation(CGPoint.zero, in: targetView)
        var velocity = recoginizer.velocity(in: targetView)
        switch recoginizer.state {
        case .began:
            if velocity.x > 0 { recoginizer.state = .cancelled }
        case .changed:
            if velocity.x > 0 { targetView.center.x = point.x-55.adjusted }
        case .ended:
            if targetView.center.x + translation.x < 35.adjusted {
                UIView.animate(withDuration: 0.3, animations: {
                    targetView.center.x = point.x-55.adjusted
                }, completion: completion)
                
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    targetView.center.x = point.x-55.adjusted
                })
            }
        @unknown default:
            break
        }
    }
    
    func ticketCoverAnimate(_ sender: UIPanGestureRecognizer, targetView: UIView, completion: (((Bool) -> Void)?)) {
        var viewTranslation = CGPoint(x: 0, y: 0)
        var viewVelocity = CGPoint(x: 0, y: 0)
        
        viewTranslation = sender.translation(in: targetView)
        viewVelocity = sender.velocity(in: targetView)
        
        switch sender.state {
        case .changed:
            if abs(viewVelocity.y) > abs(viewVelocity.x) {
                
                if viewTranslation.y >= 152 {
                    UIView.animate(withDuration: 0.1, animations: {
                        targetView.transform = CGAffineTransform(translationX: 0, y: 600)
                        sender.state = .ended
                    }, completion: completion)
                }
                
                else if viewVelocity.y > 0 {
                    UIView.animate(withDuration: 0.1, animations: {
                        targetView.transform = CGAffineTransform(translationX: 0, y: viewTranslation.y)
                    })
                }
            }
            
        case .ended:
            if viewTranslation.y < 152 {
                UIView.animate(withDuration: 0.04, animations: {
                    targetView.transform = .identity
                })
            }
            
        default:
            break
            
        }
        
    }
}

