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
    var hasSlide = Bool()
    
    // MARK: - UI Components
    
    public lazy var homeNavigationView = HomeNavigationView()
    public lazy var homeAllView = HomeAllView()
    
    public lazy var homeWeeklyView = HomeWeeklyView()
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
        
        homeWeeklyView.isHidden = false
        homeAllView.isHidden = true
        
        if !hasSlide {
            homeWeeklyView.homeWeeklySlideYetView.isHidden = false
            homeWeeklyView.homeWeeklySlidedView.isHidden = true
        }
        else {
            homeWeeklyView.homeWeeklySlideYetView.isHidden = true
            homeWeeklyView.homeWeeklySlidedView.isHidden = false
        }
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
        
        self.addSubviews(homeWeeklyView, homeAllView, homeNavigationView)
        
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
        
        homeAllView.snp.makeConstraints {
            $0.top.equalTo(homeNavigationView.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
        
    }
    
    func dataBindArticleSlideCheck(articleData: HomeArticleCheckResult?) {
        print("😵‍💫실행됨")
        guard let hasSlide = articleData?.hasSlide else { return }
        self.hasSlide = hasSlide
        self.homeWeeklyView.homeWeeklySlideYetView.isHidden = hasSlide
        self.homeWeeklyView.homeWeeklySlidedView.isHidden = !hasSlide
    }
    
}
