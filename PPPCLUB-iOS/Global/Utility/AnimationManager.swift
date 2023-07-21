//
//  AnimationManager.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/21.
//

import UIKit

class AnimationManager {
    static let shared = AnimationManager()
    
    private init() {}
    
    func ticketToggleButtonAnimate(
        targetView: UIView,
        translationX: CGFloat?,
        selectedLabel: UILabel,
        unSelectedLable: UILabel,
        completion: (((Bool) -> Void)?)
    ) {
        let transform: CGAffineTransform
        if let translationX {
            transform = CGAffineTransform(translationX: translationX.adjusted, y: 0)
        } else {
            transform = .identity
        }
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                targetView.transform = transform
                selectedLabel.textColor = .pppWhite
                unSelectedLable.textColor = .pppGrey4
                
                
            }, completion: completion)
        
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
            if velocity.x > 0 { targetView.center.x = point.x-55 }
        case .ended:
            if targetView.center.x + translation.x < 35 {
                UIView.animate(withDuration: 0.3, animations: {
                    targetView.center.x = point.x-55
                }, completion: completion)
                
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    targetView.center.x = point.x-55
                })
            }
        @unknown default:
            break
        }
    }
}

