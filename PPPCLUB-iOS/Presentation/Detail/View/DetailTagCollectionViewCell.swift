//
//  DetailTagCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

class DetailTagCollectionViewCell: UICollectionViewCell {
    
    lazy var tagView = PPPTagView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hieararchy()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func hieararchy() {
        contentView.addSubview(tagView)
    }
    
    private func layout() {
        tagView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
