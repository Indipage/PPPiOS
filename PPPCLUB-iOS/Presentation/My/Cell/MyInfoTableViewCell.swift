//
//  MyInfoTableViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyInfoTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    private let infoTitleLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellStyle()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func target() {
    }
    
    private func cellStyle() {
        infoTitleLabel.do {
            $0.font = .pppBody4
            $0.textColor = .pppBlack
        }
        
        arrowImageView.do {
            $0.image = Image.right
        }
    }
    
    private func hierarchy() {
        contentView.addSubviews(infoTitleLabel, arrowImageView)
    }
    
    private func layout() {
        infoTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(23)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
            $0.size.equalTo(24)
        }
    }
    
    func configureCell(title: String) {
        infoTitleLabel.text = title
    }
}




