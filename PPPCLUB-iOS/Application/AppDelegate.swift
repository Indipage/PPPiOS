//
//  AppDelegate.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // 앱 시작 시 루트 뷰 컨트롤러 설정
//            let initialViewController: UIViewController
//            if TokenManager.shared.isTokenExist() {
//                // 토큰이 있을 경우, 메인 뷰 컨트롤러로 설정
//                initialViewController = PPPTabBarController()
//            } else {
//                // 토큰이 없을 경우, 로그인 뷰 컨트롤러로 설정
//                initialViewController = OnboardingLoginViewController()
//            }
//            
//            // 네비게이션 컨트롤러 초기화
//            let navigationController = UINavigationController(rootViewController: initialViewController)
//
//            window = UIWindow(frame: UIScreen.main.bounds)
//            window?.rootViewController = navigationController
//            window?.makeKeyAndVisible()

            return true
        }
        

// MARK: UISceneSession Lifecycle

func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
}

func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


}

