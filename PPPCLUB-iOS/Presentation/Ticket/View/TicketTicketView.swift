//
//  TicketView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class TicketTicketView: UIView {
    
    // MARK: - UI Components
    
    let noTicketView = TicketEmptyView()
    let ticketCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        
        style()
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func register() {
        ticketCollectionView.register(TicketCollectionViewCell.self, forCellWithReuseIdentifier: TicketCollectionViewCell.cellIdentifier)
    }
    
    private func style() {
        noTicketView.do {
            $0.isHidden = true
        }
        ticketCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            $0.collectionViewLayout = layout
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .pppWhite
        }
    }
    
    private func hieararchy() {
        self.addSubviews(noTicketView, ticketCollectionView)
    }
    
    private func layout() {
        noTicketView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ticketCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(220.adjusted)
        }
    }
}


