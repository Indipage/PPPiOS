//
//  PPPTabBarController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

class PPPTabBarController: UITabBarController {
    
    
    //MARK: - Properties
    
    let homeViewController = HomeViewController()
    let searchViewController = SearchViewController()
    let myViewController = MyViewController()
    let bookmarkController = BookmarkViewController()
    
    lazy var homeNavigationContrller = UINavigationController(rootViewController: homeViewController)
    lazy var searchNavigationContrller = UINavigationController(rootViewController: searchViewController)
    lazy var myNavigationContrller = UINavigationController(rootViewController: myViewController)
    lazy var bookmarkNavigationContrller = UINavigationController(rootViewController: bookmarkController)
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
        setStyle()
        setNavigationController()
        setViewController()
        setCornerRadius()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 100
        tabBar.frame.origin.y = view.frame.height - 100
    }
    
    //MARK: - Custom Method
    
    private func setTabBar(){
        
        //tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 130
    }
    
    private func setStyle(){
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.15, x: 0, y: -2, blur: 4)
    }
    
    private func setCornerRadius(){
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner,
                                      .layerMaxXMinYCorner]
    }
    
    private func setNavigationController() {
        homeNavigationContrller.setNavigationBarHidden(true, animated: true)
        searchNavigationContrller.setNavigationBarHidden(true, animated: true)
        myNavigationContrller.setNavigationBarHidden(true, animated: true)
        bookmarkNavigationContrller.setNavigationBarHidden(true, animated: true)
    }
    
    private func setViewController(){
        homeNavigationContrller.tabBarItem = UITabBarItem(title: "홈", image: nil, selectedImage: nil)
        searchNavigationContrller.tabBarItem = UITabBarItem(title: "검색", image: nil, selectedImage: nil)
        bookmarkNavigationContrller.tabBarItem = UITabBarItem(title: "북마크", image: nil, selectedImage: nil)
        myNavigationContrller.tabBarItem = UITabBarItem(title: "마이", image: nil, selectedImage: nil)
        
        viewControllers = [
            homeNavigationContrller,
            searchNavigationContrller,
            bookmarkNavigationContrller,
            myNavigationContrller
        ]
    }
}


