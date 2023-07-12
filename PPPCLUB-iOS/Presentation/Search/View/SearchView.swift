//
//  SearchView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class SearchView: UIView {
        
    // MARK: - UI Components
    
    lazy var searchTableView = UITableView()
    private lazy var searchLabel = UILabel()
    
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
        searchTableView.do {
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
        
        searchLabel.do {
            $0.text = "전체"
            $0.font = .pppSubHead1
            $0.textColor = .pppBlack
        }
    }
    
    private func hierarchy() {
        self.addSubviews(searchLabel,
                         searchTableView
        )
    }
    
    private func layout() {
        searchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(28)
            $0.height.equalTo(24)
        }
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(searchLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }
}
