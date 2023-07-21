//
//  TicketCardCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

//MARK: - TicketCardDelegate

protocol TicketCardDelegate: AnyObject {
    func cardImageButtonDidTap(image: UIImage?)
}

final class TicketCardCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var delegate: TicketCardDelegate?
    private var cardID: Int?
    private var spaceID: Int?
    
    //MARK: - UI Components
    
    private lazy var cardImageButton = UIButton()
    
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
        cardImageButton.addTarget(self, action: #selector(cardImageButtonDidTap), for: .touchUpInside)
    }
    
    private func style() {
        cardImageButton.do {
            $0.makeCornerRadius(ratio: 4.adjusted)
            $0.makeShadow(color: .black, offset: CGSize(width: 2, height: 2), radius: 2.5, opacity: 0.25)
            $0.contentMode = .scaleToFill
        }
    }
    
    private func hierarchy() {
        contentView.addSubview(cardImageButton)
    }
    
    private func layout() {
        cardImageButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - Action Method
    
    @objc func cardImageButtonDidTap() {
        delegate?.cardImageButtonDidTap(image: cardImageButton.currentImage)
    }
}

//MARK: - TicketCardCollectionViewCell

extension TicketCardCollectionViewCell {
    func configureCell(card: TicketCardResult) {
        self.cardID = card.cardID
        self.spaceID = card.spaceID
        cardImageButton.kfSetButtonImage(url: card.imageURL, state: .normal)
    }
}




