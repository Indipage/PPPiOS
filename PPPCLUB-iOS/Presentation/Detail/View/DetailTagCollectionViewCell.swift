//
//  DetailTagCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class DetailTagCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    lazy var tagView = PPPTagView()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        hieararchy()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func hieararchy() {
        contentView.addSubview(tagView)
    }
    
    private func layout() {
        tagView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(18)
        }
    }
    
    func configureCell(text: String) {
        tagView.tagLabel.text = text
    }
}
