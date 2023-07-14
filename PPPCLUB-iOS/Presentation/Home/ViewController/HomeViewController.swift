//
//  ArticleViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let rootView = HomeView()
    
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

    private func style() {}

    private func hierarchy() {}

    private func layout() {}
        
    
    //MARK: - Action Method
    
}
