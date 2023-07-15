//
//  ArticleView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class HomeView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    public lazy var homeNavigationView = HomeNavigationView()
    public lazy var homeWeeklyView = HomeWeeklyView()
    public lazy var homeAllView = HomeAllView()
    
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
    
        homeNavigationView.do {
            $0.backgroundColor = .pppWhite
        }
        
        homeWeeklyView.do {
            $0.backgroundColor = .pppWhite
        }
        
        homeAllView.do {
            $0.backgroundColor = .pppWhite
        }
    }
    
    private func hierarchy() {
        
        self.addSubviews(homeNavigationView, homeWeeklyView)

    }
    
    private func layout() {

        homeNavigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(77)
        }
        
        homeWeeklyView.snp.makeConstraints {
            $0.top.equalTo(homeNavigationView.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
}
