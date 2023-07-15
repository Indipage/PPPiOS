//
//  HomeArticleView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

class HomeArticleView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    public lazy var articleNavigationView = HomeArticleNavigationView()
    public lazy var articleTableView = HomeArticleTableView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        
        self.backgroundColor = .pppWhite
        
        articleNavigationView.do {
            $0.backgroundColor = .white
        }
        articleTableView.do {
            $0.backgroundColor = .white
            $0.isScrollEnabled = true
        }
    }
    
    private func hierarchy() {
        
        self.addSubviews(articleNavigationView,
                                  articleTableView)
        
    }
    
    private func layout() {
        
        articleNavigationView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(66)
            $0.width.equalToSuperview()
        }
        
        articleTableView.snp.makeConstraints {
            $0.top.equalTo(articleNavigationView.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
