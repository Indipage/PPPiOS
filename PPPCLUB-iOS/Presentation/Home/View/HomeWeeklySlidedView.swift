//
//  HomeWeeklySlidedView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/21.
//

import UIKit

class HomeWeeklySlidedView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        
        register()
        style()
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func register() {
        
        self.register(ThisWeekCell.self, forCellWithReuseIdentifier: ThisWeekCell.cellIdentifier)
        self.register(NextWeekCell.self, forCellWithReuseIdentifier: NextWeekCell.cellIdentifier)
        
    }
    
    private func style() {
        self.do {
            let layout = AllCustomFlowLayout()
            layout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = layout
            $0.frame = .zero
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = true
            $0.contentInsetAdjustmentBehavior = .never
        }
    }

    
}
