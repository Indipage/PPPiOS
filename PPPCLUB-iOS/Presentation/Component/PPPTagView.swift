//
//  PPPTagView.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class PPPTagView: UIView {
    
    // MARK: - UI Components

    lazy var tagLabel = UILabel()
    private let emptyLabel1 = UILabel()
    private let emptyLabel2 = UILabel()
    lazy var tagStackView = UIStackView(arrangedSubviews: [emptyLabel1,
                                                           tagLabel,
                                                           emptyLabel2])
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        hieararchy()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        tagStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
            $0.layer.cornerRadius = 17
            $0.layer.backgroundColor = UIColor.pppBlack.cgColor
        }
        
        tagLabel.do {
            $0.font = .pppBody6
            $0.textColor = .white
            $0.textAlignment = .center
            $0.frame.size = $0.intrinsicContentSize
        }
    }
    
    private func hieararchy() {
        addSubview(tagStackView)
    }
    
    private func layout() {
        tagStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyLabel1.snp.makeConstraints {
            $0.width.equalTo(16)
        }
        
        emptyLabel2.snp.makeConstraints {
            $0.width.equalTo(16)
        }
    }
}
