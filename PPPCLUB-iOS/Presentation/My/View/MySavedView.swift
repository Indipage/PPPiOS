//
//  MySavedView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

enum SavedViewType {
    case article
    case store
    
    var image: UIImage? {
        switch self {
        case .article:
            return Image.savedArticle
        case .store:
            return Image.savedSpace
        }
    }
    
    var title: String {
        switch self {
        case .article:
            return "Article"
        case .store:
            return "Store"
        }
    }
    
    var subTitle: String {
        switch self {
        case .article:
            return "저장한 아티클"
        case .store:
            return "저장한 서점"
        }
    }
    
    var nextVC: UIViewController {
        switch self {
        case .article:
            return MySavedArticleViewController()
        case .store:
            return MySavedBookStoreViewController()
        }
    }
}

final class MySavedView: UIView {
    
    //MARK: - Properties
    
    let savedViewType: SavedViewType?
    
    //MARK: - UI Components
    
    private var savedImageView = UIImageView()
    private var savedTitleLabel = UILabel()
    private var savedSubTitleLabel = UILabel()
    
    
    // MARK: - Life Cycle
    
    init(frame: CGRect, savedViewType: SavedViewType) {
        self.savedViewType = savedViewType
        
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
        self.do {
            $0.backgroundColor = .pppWhite
            $0.makeCornerRadius(ratio: 4)
        }
        
        savedImageView.do {
            $0.image = savedViewType?.image
            $0.makeCornerRadius(ratio: 4)
            $0.backgroundColor = .pppGrey3
        }
        
        savedTitleLabel.do {
            $0.text = savedViewType?.title
            $0.textColor = .pppBlack
            $0.textAlignment = .center
            $0.font = .pppEnBody2
        }
        
        savedSubTitleLabel.do {
            $0.text = savedViewType?.subTitle
            $0.textColor = .pppGrey5
            $0.textAlignment = .center
            $0.font = .pppCaption1
        }
    }
    
    private func hierarchy() {
        self.addSubviews(savedImageView, savedTitleLabel, savedSubTitleLabel)
    }
    
    private func layout() {
        savedImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(74)
        }
        
        savedTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.savedImageView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
        }
        
        savedSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.savedTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(self.savedTitleLabel)
        }
    }
    
}
