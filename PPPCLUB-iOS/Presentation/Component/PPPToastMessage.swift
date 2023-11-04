//
//  PPPToastMessage.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/11/01.
//

import UIKit

import SnapKit
import Then

protocol PPPToastMessageDelegate: AnyObject {
    func pushTicketView()
}

class PPPToastMessage: UIView {
    
    //MARK: - Properties
    
    weak var delegate: PPPToastMessageDelegate?
    
    //MARK: - UI Components
    
    private let toastMessageLabel = UILabel()
    lazy var toastButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        self.do {
            $0.backgroundColor = .pppGrey9
        }
        
        toastMessageLabel.do {
            $0.text = "티켓을 받았어요!"
            $0.font = .pppBody4
            $0.textColor = .pppWhite
        }
        
        toastButton.do {
            $0.setTitle("티켓함 가기", for: .normal)
            $0.titleLabel?.font = .pppBody3
            $0.setTitleColor(.pppMainLightGreen, for: .normal)
            $0.addTarget(self, action: #selector(toastBtnTap), for: .touchUpInside)
        }
    }
    
    private func hierarchy() {
        self.addSubviews(toastMessageLabel, toastButton)
    }
    
    private func layout() {
        toastMessageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        toastButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(73)
            $0.height.equalTo(22)
        }
    }
    
    //MARK: - Action Method
    @objc
    private func toastBtnTap() {
        delegate?.pushTicketView()
    }
}
