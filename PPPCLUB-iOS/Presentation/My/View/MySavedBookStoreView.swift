//
//  MySavedBookStoreView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class MySavedBookStoreView: UIView {
    
    // MARK: - UI Components
    
    private let savedBookStoreNavigationBar = UIView()
    lazy var backButton = UIButton()
    private let titleLabel = UILabel()
    let savedBookStoreTableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        
        style()
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func register() {
        savedBookStoreTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.cellIdentifier)
    }
    
    private func style() {
        savedBookStoreTableView.do {
            $0.showsVerticalScrollIndicator = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.separatorStyle = .none
        }
        
        backButton.do {
            $0.setImage(Image.arrowDown, for: .normal)
        }
        
        titleLabel.do {
            $0.text = "저장한 서점"
            $0.font = .pppSubHead1
            $0.textColor = .pppBlack
        }
    }
    
    private func hieararchy() {
        self.addSubviews(savedBookStoreNavigationBar, savedBookStoreTableView)
        savedBookStoreNavigationBar.addSubviews(backButton, titleLabel)
    }
    
    private func layout() {
        savedBookStoreNavigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(62.adjusted)
        }
        
        savedBookStoreTableView.snp.makeConstraints {
            $0.top.equalTo(self.savedBookStoreNavigationBar.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(28)
            $0.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(9.adjusted)
            $0.leading.equalToSuperview().offset(14)
            $0.size.equalTo(42.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}

