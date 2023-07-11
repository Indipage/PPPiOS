//
//  MyView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class MyView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let profileView = MyProfileView()
    lazy var infoTableView = MyInfoView()
    
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
        scrollView.do {
            $0.backgroundColor = .white
            $0.isScrollEnabled = true
            $0.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        }
    }
    
    private func hierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(profileView, infoTableView)
    }
    
    private func layout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
            $0.width.equalTo(scrollView.safeAreaLayoutGuide)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(382)
        }
        infoTableView.snp.makeConstraints {
            $0.top.equalTo(self.profileView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(100)
        }
    }
}
