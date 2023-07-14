//
//  HomeArticleTableViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/13.
//

import UIKit

import SnapKit
import Then

class HomeArticleTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    static let identifier = "HomeArticleTableViewCell"
    private let exampleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellstyle()
        hierarchy()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Custom Method
    
    private func cellstyle() {
        
        selectionStyle = .none
        
        exampleLabel.do {
            $0.text = "서버를 받아올까요?"
            $0.font = .systemFont(ofSize: 10)
            $0.textColor = .black
        }
        
    }
    
    private func hierarchy() {
        
        contentView.addSubviews(exampleLabel)
        
    }
    
    private func layout() {
        
        exampleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        
    }
}
