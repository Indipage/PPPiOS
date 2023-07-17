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
    private var cellTitleLabel = UILabel()
    private var cellImageView = UIImageView()
    private var cellBodyLabel = UILabel()
    
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
        
        cellTitleLabel.do {
            $0.font = .pppSubHead1
            $0.textColor = .pppBlack
            $0.textAlignment = .justified
            $0.numberOfLines = 0
        }
        
        cellBodyLabel.do {
            $0.font = .pppBody5
            $0.textColor = .pppBlack
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }
        
    }
    
    private func hierarchy() {
        
        contentView.addSubview(cellTitleLabel ?? UIView())
        contentView.addSubview(cellImageView ?? UIView())
        contentView.addSubview(cellBodyLabel ?? UIView())
        
    }
    
    private func layout() {
        
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(33)
            
        }
        
        cellImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(33)
        }
        
        cellBodyLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(33)
        }
        
        
    }
}

extension HomeArticleTableViewCell {
    func configureCell(article: [String?]) {
        if var articleType = article[0] {
            if var articleContent = article[1]{
                switch articleType {
                case "title":
                    cellTitleLabel.text = articleContent
                case "img":
                    cellImageView.kfSetImage(url: articleContent)
                    break
                case "body":
                    cellBodyLabel.text = articleContent
                default:
                    break
                }
            }
        }
    }
}
