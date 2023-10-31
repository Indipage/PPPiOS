//
//  OnboardingCollectionView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 10/30/23.
//

import UIKit

class OnboardingInfoView: UIView {
    
    let onboardingInfoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let pageControl = UIPageControl()
    let welcomeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        
        style()
        hieararchy()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func register() {
        
        onboardingInfoCollectionView.register(OnboardingInfoCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingInfoCollectionViewCell.cellIdentifier)
        
    }
    
    private func style() {
        onboardingInfoCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            $0.isPagingEnabled = true
            $0.decelerationRate = UIScrollView.DecelerationRate.fast
            $0.collectionViewLayout = layout
            $0.showsVerticalScrollIndicator = true
            $0.isScrollEnabled = true
        }
        
        pageControl.do {
            $0.hidesForSinglePage = true
            $0.numberOfPages = OnboardingInfoModel.mockDummy().count-1
            $0.pageIndicatorTintColor = .pppGrey4
            $0.currentPageIndicatorTintColor = .pppMainPurple
        }
        
        welcomeButton.do {
            $0.setTitle("PPP Club 입장하기", for: .normal)
            $0.titleLabel?.font = .pppSubHead2
            $0.layer.cornerRadius = 15
            $0.layer.backgroundColor = UIColor.pppMainPurple.cgColor
            $0.isHidden = true
        }
    }
    private func hieararchy() {
        self.addSubviews(onboardingInfoCollectionView, pageControl, welcomeButton)
    }
    private func layout() {
        onboardingInfoCollectionView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints() {
            $0.top.equalToSuperview().inset(75)
            $0.centerX.equalToSuperview()
        }
        
        welcomeButton.snp.makeConstraints() {
            $0.bottom.equalToSuperview().inset(60)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(47)
            $0.height.equalTo(60)
        }
    }
}
