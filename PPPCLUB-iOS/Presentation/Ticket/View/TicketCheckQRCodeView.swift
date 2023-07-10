//
//  TicketCheckQRCodeView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class TicketCheckQRCodeView: UIView {
    
    //MARK: - UI Components
    
    private let describeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        describeLabel.do {
            $0.text = "서점 내 QR 코드를 스캔해보세요 !"
        }
    }
    private func hierarchy() {
        self.addSubview(describeLabel)
    }
    private func layout() {
        describeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(173)
            $0.centerX.equalToSuperview()
        }
    }
}
