//
//  DetailBookCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class DetailBookCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    lazy var bookImageView = UIImageView()
    
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
    
    private func style() {
        bookImageView.do {
            $0.backgroundColor = .pppGrey3
            $0.image = Image.mockBook
            $0.contentMode = .scaleAspectFill
        }
    }
    
    private func hieararchy() {
        contentView.addSubview(bookImageView)
    }
    
    private func layout() {
        bookImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureCell(image: UIImage) {
        bookImageView.image = image
    }
}

