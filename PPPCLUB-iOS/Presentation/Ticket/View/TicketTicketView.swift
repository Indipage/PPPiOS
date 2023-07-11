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
    
    // MARK: - Properties
    
    let ticketCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - UI Components
    
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
        ticketCollectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = false
            $0.alwaysBounceVertical = true
            $0.backgroundColor = .systemPink
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
        }
    }
    
    private func hieararchy() {
        self.addSubview(ticketCollectionView)
    }
    
    private func layout() {
        ticketCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


