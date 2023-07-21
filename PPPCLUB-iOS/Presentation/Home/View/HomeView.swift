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
    public lazy var homeWeeklyView = HomeWeeklyView()
    public lazy var homeAllView = HomeAllView()
    var weeklyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        register()
        
        style()
        hierarchy()
        layout()
        
        homeWeeklyView.isHidden = false
        homeAllView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func register() {
        
        weeklyCollectionView.register(thisWeekCell.self, forCellWithReuseIdentifier: thisWeekCell.cellIdentifier)
        weeklyCollectionView.register(nextWeekCell.self, forCellWithReuseIdentifier: nextWeekCell.cellIdentifier)
        
    }
    
    private func style() {
    
        homeNavigationView.do {
            $0.backgroundColor = .pppWhite
        }
        
        homeWeeklyView.do {
            $0.backgroundColor = .pppWhite
            
            if hasSlide {
                $0.isHidden = true
            }
            else {
                $0.isHidden = false
                }
        }
        
        homeAllView.do {
            $0.backgroundColor = .pppWhite
        }
        
        weeklyCollectionView.do {
            let layout = AllCustomFlowLayout()
                layout.scrollDirection = .horizontal
                $0.collectionViewLayout = layout
                $0.showsVerticalScrollIndicator = false
                $0.isScrollEnabled = true
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.showsHorizontalScrollIndicator = true
                $0.contentInsetAdjustmentBehavior = .never
            
            if hasSlide {
                $0.isHidden = false
            }
            else {
                $0.isHidden = true
                }
        }
        
    }
    
    private func hierarchy() {
        
        self.addSubviews(homeWeeklyView, homeAllView, weeklyCollectionView, homeNavigationView)

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
        
        weeklyCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(600)
        }
        
    }
    
}
