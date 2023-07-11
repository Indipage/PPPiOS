//
//  TicketCardCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class TicketCardCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    
    private let ticketImageView = UIView()
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - Custom Method
    
    private func style() {
        ticketImageView.do {
            $0.backgroundColor = .blue
            $0.makeCornerRadius(ratio: 4)
            $0.makeShadow(color: .black, offset: CGSize(width: 2, height: 2), radius: 2.5, opacity: 0.25)
        }
    }
    
    private func hierarchy() {
        contentView.addSubview(ticketImageView)
    }
    
    private func layout() {
        ticketImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}




