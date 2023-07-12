//
//  MySeparatorCell.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MySeparatorFooterView: UITableViewHeaderFooterView {
    
    //MARK: - UI Components
    
    private let separator = UIView()
    
    //MARK: - Life Cycles
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        cellStyle()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func cellStyle() {
        separator.do {
            $0.backgroundColor = .pppGrey2
        }
    }
    
    private func hierarchy() {
        contentView.addSubview(separator)
    }
    
    private func layout() {
        separator.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}





