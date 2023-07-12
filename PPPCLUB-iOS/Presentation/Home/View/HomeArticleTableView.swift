//
//  HomeArticleTableView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

class HomeArticleTableView: UITableView {
    // MARK: - Properties
    
    // MARK: - UI Components
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        tableStyle()
        
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func tableStyle() {
        self.do {
            $0.backgroundColor = .pppWhite
            $0.showsVerticalScrollIndicator = true
            $0.separatorStyle = .none
        }
        
    }
    
    private func register() {
        self.register(HomeArticleHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeArticleHeaderView.cellIdentifier)
        
        self.register(HomeArticleFooterView.self, forHeaderFooterViewReuseIdentifier: HomeArticleFooterView.cellIdentifier)
    }
    
}


