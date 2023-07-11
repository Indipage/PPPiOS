//
//  MySavedView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class MySavedView: UIView {
    
    //MARK: - Properties
    
//    let image: UIImage?
//    let title: String?
//    let subTitle: String?
    
    
    //MARK: - UI Components
    
    private var savedImageView = UIImageView()
    private var savedTitleLabel = UILabel()
    private var savedSubTitleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func style() {
        self.backgroundColor = .white
        
        savedImageView.do {
            $0.backgroundColor = .blue
        }
        
        savedTitleLabel.do {
            $0.text = "Article"
        }
        
        savedSubTitleLabel.do {
            $0.text = "저장한 아티클"
        }
    }
    
    private func hieararchy() {
        self.addSubviews(savedImageView, savedTitleLabel, savedSubTitleLabel)
    }
    
    private func layout() {
        savedImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(74)
        }
        
        savedTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.savedImageView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
        }
        
        savedSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.savedTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(self.savedTitleLabel)
        }
    }
    
}
