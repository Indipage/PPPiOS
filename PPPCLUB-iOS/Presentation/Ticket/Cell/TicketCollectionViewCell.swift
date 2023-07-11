//
//  TicketCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

protocol TicketDelegate: AnyObject {
    func ticketImageDidSwapped()
}

final class TicketCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var delegate: TicketDelegate?
    
    //MARK: - UI Components
    
    private let ticketImageView = UIButton()
    
    //MARK: - Life Cycles
    
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

    //MARK: - Custom Method
    
    private func target() {
        ticketImageView.addTarget(self, action: #selector(ticketImageDidSwapped), for: .touchUpInside)
    }
    
    private func style() {
        ticketImageView.do {
            $0.backgroundColor = .blue
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
    
    //MARK: - Action Method
    
    @objc func ticketImageDidSwapped() {
        delegate?.ticketImageDidSwapped()
    }
}



