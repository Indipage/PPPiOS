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
    let profileView = MyProfileView()
    lazy var infoTableView = MyInfoView()
    private let appInformationLabel = UILabel()
    
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
        }
        
        appInformationLabel.do {
            $0.text = "앱 버전 v.1.1.0"
            $0.textColor = .pppBlack
            $0.font = .pppCaption1
        }
    }
    
    private func hierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(profileView, infoTableView, appInformationLabel)
    }
    
    private func layout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(382)
        }
        
        infoTableView.snp.makeConstraints {
            $0.top.equalTo(self.profileView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(235)
        }
        
        appInformationLabel.snp.makeConstraints {
            $0.top.equalTo(self.infoTableView.snp.bottom)
            $0.leading.equalToSuperview().offset(28)
            $0.bottom.equalToSuperview()
        }
    }
}
