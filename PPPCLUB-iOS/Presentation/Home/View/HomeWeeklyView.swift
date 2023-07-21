//
//  HomeWeeklyView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/14.
//

import UIKit

class HomeWeeklyView: UIView {
    
    public lazy var homeWeeklySlideYetView = HomeWeeklySlideYetView()
    public lazy var homeWeeklySlidedView = HomeWeeklySlidedView()
    
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
        
        homeWeeklySlideYetView.isHidden = true
        homeWeeklySlidedView.isHidden = true
        
    }
    
    private func hierarchy() {
        
        self.addSubviews(homeWeeklySlideYetView, homeWeeklySlidedView)
    }
    
    private func layout() {
       
        homeWeeklySlideYetView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        homeWeeklySlidedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func dataBindArticleSlideCheck(articleData: HomeArticleCheckResult?) {
        
        guard let hasSlide = articleData?.hasSlide else { return }
        self.homeWeeklySlideYetView.isHidden = hasSlide
        self.homeWeeklySlidedView.isHidden = !hasSlide
    }
}
