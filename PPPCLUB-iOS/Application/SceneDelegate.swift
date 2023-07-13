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
        let navigationController = UINavigationController(rootViewController: PPPTabBarController())
        navigationController.isNavigationBarHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
