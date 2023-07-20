//
//  WeeklyCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/21.
//

import UIKit

import SnapKit
import Then

//class WeeklyCollectionViewCell: UICollectionViewCell {
//    
//}

class thisWeekCell: UICollectionViewCell {
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellStyle()
//        hierarchy()
//        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellStyle() {
        self.backgroundColor = .pppMainPurple
    }
    private func hierarchy() {
        
    }
    private func layout() {
    }
}

class nextWeekCell: UICollectionViewCell {
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellStyle()
//        hierarchy()
//        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellStyle() {
        self.backgroundColor = .pppMainLightGreen
    }
    private func hierarchy() {
        
    }
    private func layout() {
        
    }
    
}
