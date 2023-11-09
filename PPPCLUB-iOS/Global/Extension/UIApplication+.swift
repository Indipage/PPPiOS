//
//  UIApplication+.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/11/06.
//

import UIKit

extension UIApplication {
    
    var firstWindow: UIWindow? {
        if #available(iOS 13, *) {
            return (UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow })
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    var rootViewController: UIViewController? {
        return firstWindow?.rootViewController
    }
    
    func changeRootViewController(_ viewController: UIViewController) {
        guard let firstWindow = firstWindow else {
            print("윈도우 생성 전입니다.")
            return
        }
        
        // 네트워크 에러 Window라면 가드
        guard firstWindow.windowLevel != .statusBar else {
            let scenes = UIApplication.shared.connectedScenes
            let windowScenes = scenes.first as? UIWindowScene
            windowScenes?.windows.first?.rootViewController = viewController
            windowScenes?.windows.first?.makeKeyAndVisible()
            UIView.transition(with: firstWindow,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: nil)
            return
        }
        
        firstWindow.rootViewController = viewController
        firstWindow.makeKeyAndVisible()
        UIView.transition(with: firstWindow,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
}

