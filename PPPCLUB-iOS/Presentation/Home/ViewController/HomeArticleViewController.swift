//
//  HomeArticleViewController.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/12.
//

import UIKit

import SnapKit
import Then


class HomeArticleViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    private var rootView = HomeArticleView()
    private var navigationView = HomeArticleNavigationView()
    
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
    
    private func target() {}
    
    private func register() {}
    
    private func delegate() {}
    
    private func style() {
        navigationView.do {
            $0.backgroundColor = .white
        }
    }
    
    private func hierarchy() {
        self.view.addSubviews(navigationView)
    }
    
    private func layout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(66)
            $0.width.equalToSuperview()
        }
    }
    
    //MARK: - Action Method
    
}
