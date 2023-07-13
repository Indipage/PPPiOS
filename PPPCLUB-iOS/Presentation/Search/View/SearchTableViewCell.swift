//
//  SearchTableViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    lazy var placeImageView = UIImageView()
    lazy var placeNameLabel = UILabel()
    lazy var locationLabel = UILabel()
    private lazy var infoStackView = UIStackView(arrangedSubviews: [placeNameLabel,
                                                                    locationLabel])
    
    // MARK: - Lift Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setConstraint()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func setUI() {
        placeImageView.do {
            $0.layer.cornerRadius = 5
            $0.layer.masksToBounds = true
            $0.clipsToBounds = true
            $0.contentMode = .scaleToFill
        }
        
        placeNameLabel.do {
            $0.font = .pppBody4
            $0.textColor = .pppBlack
        }
        
        locationLabel.do {
            $0.font = .pppCaption1
            $0.textColor = .pppGrey6
            $0.numberOfLines = 2
        }
        
        infoStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 5
        }
    }
    
    func setConstraint() {
        contentView.addSubviews(placeImageView,
                                infoStackView
        )
    }
    
    func setLayout() {
        placeImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.height.width.equalTo(84)
            $0.leading.equalToSuperview()
        }
        
        infoStackView.snp.makeConstraints {
            $0.centerY.equalTo(placeImageView)
            $0.leading.equalTo(placeImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}

extension SearchTableViewCell {
    func dataBind(image: UIImage, name: String, location: String) {
        placeImageView.image = image
        placeNameLabel.text = name
        locationLabel.text = location
    }
}
