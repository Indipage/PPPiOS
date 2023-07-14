//
//  MySavedArticleView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MySavedArticleView: UIView {
    
    // MARK: - UI Components
    
    private let savedArticleNavigationBar = UIView()
    lazy var backButton = UIButton()
    private let titleLabel = UILabel()
    let savedArticleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        
        style()
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func register() {
        savedArticleCollectionView.register(MySavedArticleCollectionViewCell.self, forCellWithReuseIdentifier: MySavedArticleCollectionViewCell.cellIdentifier)
    }
    
    private func style() {
        savedArticleCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            $0.collectionViewLayout = layout
            $0.showsVerticalScrollIndicator = true
            $0.isScrollEnabled = true
        }
        
        backButton.do {
            $0.setImage(Image.arrowDown, for: .normal)
        }
        
        titleLabel.do {
            $0.text = "저장한 아티클"
            $0.font = .pppSubHead1
            $0.textColor = .pppBlack
        }
    }
    
    private func hieararchy() {
        self.addSubviews(savedArticleNavigationBar, savedArticleCollectionView)
        savedArticleNavigationBar.addSubviews(backButton, titleLabel)
    }
    
    private func layout() {
        savedArticleNavigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(62.adjusted)
        }
        
        savedArticleCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.savedArticleNavigationBar.snp.bottom)
            $0.width.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(9.adjusted)
            $0.leading.equalToSuperview().offset(14)
            $0.size.equalTo(42.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}
