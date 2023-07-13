//
//  TicketCardView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class TicketCardView: UIView {
    
    // MARK: - Properties
    
    let noTicketCardView = TicketCardEmptyView()
    let cardImageView = UIView()
    let ticketCardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        ticketCardCollectionView.register(TicketCardCollectionViewCell.self, forCellWithReuseIdentifier: TicketCardCollectionViewCell.cellIdentifier)
    }
    
    private func style() {
        noTicketCardView.do {
            $0.isHidden = true
        }
        cardImageView.do {
            $0.backgroundColor = .gray
            $0.makeCornerRadius(ratio: 17.4)
            $0.makeShadow(color: .black, offset: CGSize(width: 4, height: 4), radius: 5, opacity: 0.25)
        }
        
        ticketCardCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .systemPink
        }
    }
    
    private func hieararchy() {
        self.addSubviews(noTicketCardView,cardImageView,ticketCardCollectionView)
    }
    
    private func layout() {
        noTicketCardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cardImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(284/Size.width)
            $0.height.equalToSuperview().multipliedBy(449/Size.height)
        }
        
        ticketCardCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.cardImageView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(28)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(108/Size.height)
        }
    }
}



