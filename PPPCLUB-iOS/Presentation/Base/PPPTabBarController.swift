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
    
    
    //MARK: - UI Components
    
    let homeViewController = HomeViewController()
    let searchViewController = SearchViewController()
    let myViewController = MyViewController()
    let ticketViewController = TicketResultViewController()
    
    lazy var homeNavigationContrller = UINavigationController(rootViewController: homeViewController)
    lazy var searchNavigationContrller = UINavigationController(rootViewController: searchViewController)
    lazy var myNavigationContrller = UINavigationController(rootViewController: myViewController)
    lazy var ticketNavigationContrller = UINavigationController(rootViewController: ticketViewController)
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
        setStyle()
        setNavigationController()
        setViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 100
        tabBar.frame.origin.y = view.frame.height - 100
    }
    
    //MARK: - Custom Method
    
    private func setTabBar(){
        tabBar.backgroundColor = .pppWhite
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 100
        
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.pppGrey3.cgColor
    }
    
    private func setStyle(){
        UITabBar.clearShadow()
    }
    
    private func setNavigationController() {
        homeNavigationContrller.setNavigationBarHidden(true, animated: true)
        searchNavigationContrller.setNavigationBarHidden(true, animated: true)
        myNavigationContrller.setNavigationBarHidden(true, animated: true)
        ticketNavigationContrller.setNavigationBarHidden(true, animated: true)
    }
    
    private func setViewController(){
        homeNavigationContrller.tabBarItem = UITabBarItem(title: nil, image: Image.article, selectedImage: Image.articleFill)
        searchNavigationContrller.tabBarItem = UITabBarItem(title: nil, image: Image.search, selectedImage: Image.searchFill)
        ticketNavigationContrller.tabBarItem = UITabBarItem(title: nil, image: Image.ticket, selectedImage: Image.ticketFill)
        myNavigationContrller.tabBarItem = UITabBarItem(title: nil, image: Image.my, selectedImage: Image.myFill)
        
        viewControllers = [
            homeNavigationContrller,
            searchNavigationContrller,
            ticketNavigationContrller,
            myNavigationContrller
        ]
    }
}


