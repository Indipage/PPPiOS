//
//  HomeArticleTableViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/13.
//

import UIKit

class HomeArticleTableViewCell: UITableViewCell {
    
    static let identifier = "HomeArticleTableViewCell"
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellstyle()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Custom Method
    
    func cellstyle() {
        selectionStyle = .none
    }
    
    func layout() {
        
    }
    
}
