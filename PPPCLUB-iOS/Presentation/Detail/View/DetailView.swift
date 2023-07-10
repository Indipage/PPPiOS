//
//  DetailView.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class DetailView: UIScrollView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    let detailTopView = DetailTopView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func hieararchy() {
        self.addSubview(detailTopView)
    }
    
    private func layout() {
        detailTopView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(381.0 / 821.0)
        }
    }
}
