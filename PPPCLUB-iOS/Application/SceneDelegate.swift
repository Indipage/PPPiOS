//
//  SceneDelegate.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light       
        let initialViewController: UIViewController
        if TokenManager.shared.isTokenExist() {
            print("토큰 잇어서 tabbarcontroller")
            initialViewController = PPPTabBarController()
        } else {
            // 토큰이 없을 경우, 로그인 뷰 컨트롤러로 설정
            print("토큰 없어서 로그인으로")
            initialViewController = OnboardingLoginViewController()
        }
        
        // 네비게이션 컨트롤러 초기화
        let navigationController = UINavigationController(rootViewController: initialViewController)

        navigationController.isNavigationBarHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

