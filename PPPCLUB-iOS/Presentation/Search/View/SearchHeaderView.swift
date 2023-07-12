//
//  SearchHeaderView.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class SearchHeaderView: UIView {
    
    // MARK: - UI Components
    
    lazy var allLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {        
        allLabel.do {
            $0.text = "전체"
            $0.font = .pppSubHead1
            $0.textColor = .pppBlack
        }
    }
    
    private func hierarchy() {
        self.addSubview(allLabel)
    }
    
    private func layout() {
        allLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
        }
    }
}
