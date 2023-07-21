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
    let ticketViewController = TicketSuccessViewController()
    
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
        
        tabBar.frame.size.height = 116.adjusted
        tabBar.frame.origin.y = view.frame.height - 100.adjusted
    }
    
    //MARK: - Custom Method
    
    private func setTabBar(){
        tabBar.backgroundColor = .pppWhite
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .pppBlack
        
        tabBar.layer.addBorder([.top], color: .pppGrey3, width: 1)
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
        homeNavigationContrller.tabBarItem = setTabBarItem(image: Image.article, selectedImage: Image.articleFill)
        searchNavigationContrller.tabBarItem = setTabBarItem(image: Image.search, selectedImage: Image.searchFill)
        ticketNavigationContrller.tabBarItem = setTabBarItem(image: Image.ticket, selectedImage: Image.ticketFill)
        myNavigationContrller.tabBarItem = setTabBarItem(image: Image.my, selectedImage: Image.myFill)
        
        viewControllers = [
            homeNavigationContrller,
            searchNavigationContrller,
            ticketNavigationContrller,
            myNavigationContrller
        ]
    }
    
    private func setTabBarItem(image: UIImage, selectedImage: UIImage) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        return tabBarItem
    }
}


