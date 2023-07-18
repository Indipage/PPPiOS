//
//  HomeAllView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/16.
//

import UIKit

class HomeAllView: UIView {
        
        // MARK: - Properties
        
        // MARK: - UI Components
        
    let allArticleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        // MARK: - Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)

            register()
            
            style()
            hierarchy()
            layout()

        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Custom Method
        
    private func register() {
        
        allArticleCollectionView.register(MySavedArticleCollectionViewCell.self, forCellWithReuseIdentifier: MySavedArticleCollectionViewCell.cellIdentifier)
    }
    
    private func style() {
        
        allArticleCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            $0.collectionViewLayout = layout
            $0.showsVerticalScrollIndicator = true
            $0.isScrollEnabled = true
        }
    }
        
        private func hierarchy() {
            self.addSubview(allArticleCollectionView)
        }
        
        private func layout() {
            allArticleCollectionView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.width.bottom.equalToSuperview()
            }
        }

}
