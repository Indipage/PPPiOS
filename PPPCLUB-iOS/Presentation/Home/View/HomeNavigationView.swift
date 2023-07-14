//
//  HomeNavigationView.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/14.
//

import UIKit

import Then
import SnapKit

class HomeNavigationView: UIView {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    private var weeklyButton = UIButton()
    private var allButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        target()
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func target() {
        
        weeklyButton.addTarget(self, action: #selector(weeklyButtonTap), for: .touchUpInside)
        allButton.addTarget(self, action: #selector(allButtonTap), for: .touchUpInside)
        
    }
    
    private func style() {
        
        weeklyButton.do {
            $0.layer.cornerRadius = 20
            $0.setTitle("weekly", for: .normal)
            $0.setTitleColor(.pppWhite, for: .selected)
            $0.setTitleColor(.pppGrey4, for: .normal)
            $0.titleLabel?.font = .pppEnBody2
            $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
            
            $0.isSelected = true
            $0.backgroundColor = .pppMainPurple
        }
        
        allButton.do {
            $0.layer.cornerRadius = 20
            $0.setTitle("all", for: .normal)
            $0.setTitleColor(.pppWhite, for: .selected)
            $0.setTitleColor(.pppGrey4, for: .normal)
            $0.titleLabel?.font = .pppEnBody2
            $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
            
            $0.isSelected = false
            $0.backgroundColor = .pppGrey2
        }
    }
    
    private func hierarchy() {
        
        self.addSubviews(weeklyButton, allButton)
    }
    
    private func layout() {
        
        weeklyButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(28)
            $0.bottom.equalToSuperview().inset(13)
        }
        
        allButton.snp.makeConstraints {
            $0.centerY.equalTo(weeklyButton.snp.centerY)
            $0.leading.equalTo(weeklyButton.snp.trailing).offset(10)
            $0.bottom.equalTo(weeklyButton.snp.bottom)
            
        }
    }
    
    //MARK: - Action Method
    
    @objc
    func weeklyButtonTap() {
        weeklyButton.isSelected = true
        allButton.isSelected = false
        weeklyButton.backgroundColor = .pppMainPurple
        allButton.backgroundColor = .pppGrey2
    }
    
    @objc
    func allButtonTap() {
        weeklyButton.isSelected = false
        allButton.isSelected = true
        weeklyButton.backgroundColor = .pppGrey2
        allButton.backgroundColor = .pppMainPurple
    }
}
