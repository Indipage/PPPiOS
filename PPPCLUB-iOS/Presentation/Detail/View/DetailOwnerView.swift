//
//  DetailOwnerView.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class DetailOwnerView: UIView {
    
    // MARK: - Properties
    
    private var ownerName = "바균빈"
    
    // MARK: - UI Components
    
    private lazy var ownerIntroLabel = UILabel()
    private lazy var introduceLabel = UILabel()
    private let recommendBookLabel = UILabel()
    let flowLayout = UICollectionViewFlowLayout()
    lazy var bookCollectionView = UICollectionView(frame: .zero,
                                                           collectionViewLayout: flowLayout)
    private lazy var bookNameLabel = UILabel()
    lazy var curationLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        ownerIntroLabel.do {
            $0.text = "책방지기 \(ownerName)의 한마디"
            $0.font = .pppSubHead1
            $0.textColor = .black
        }
        
        introduceLabel.do {
            $0.text = "독립서점 소개글 작성란"
            $0.font = .pppBody5
            $0.textColor = .black
            $0.backgroundColor = .pppGrey2
            $0.sizeToFit()
        }
        
        recommendBookLabel.do {
            $0.text = "💡 책방지기 추천 서가"
            $0.font = .pppTitle1
            $0.textColor = .black
        }
        
        flowLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 32
        }
        
        bookCollectionView.do {
            $0.backgroundColor = .clear
        }
        
        bookNameLabel.do {
            $0.text = "책 제목"
            $0.font = .pppTitle1
            $0.textColor = .black
        }
        
        curationLabel.do {
            $0.text = "큐레이션 멘트 진짜 엄청엄청엄청 긴 큐레이션 멘트 진짜너무긴 큐레이션멘트 완전길지? 너무 길지? 당황스럽지? 큐레이션 멘트 진짜 엄청엄청엄청 긴 큐레이션 멘트 진짜너무긴 큐레이션멘트 완전길지? 너무 길지? 당황스럽지?큐레이션 멘트 진짜 엄청엄청엄청 긴 큐레이션 멘트 진짜너무긴 큐레이션멘트 완전길지? 너무 길지? 당황스럽지? 큐레이션 멘트 진짜 엄청엄청엄청 긴 큐레이션 멘트 진짜너무긴 큐레이션멘트 완전길지? 너무 길지? 당황스럽지?큐레이션 멘트 진짜 엄청엄청엄청 긴 큐레이션 멘트 진짜너무긴 큐레이션멘트 완전길지? 너무 길지? 당황스럽지? 큐레이션 멘트 진짜 엄청엄청엄청 긴 큐레이션 멘트 진짜너무긴 큐레이션멘트 완전길지? 너무 길지? 당황스럽지?"
            $0.font = .pppBody2
            $0.textColor = .black
            $0.textAlignment = .center
            $0.numberOfLines = 15
            $0.backgroundColor = .systemBlue
            $0.sizeToFit()
        }
    }
    
    private func hieararchy() {
        self.addSubviews(ownerIntroLabel,
                         introduceLabel,
                         recommendBookLabel,
                         bookCollectionView,
                         bookNameLabel,
                         curationLabel
        )
    }
    
    private func layout() {
        ownerIntroLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        
        introduceLabel.snp.makeConstraints {
            $0.top.equalTo(ownerIntroLabel.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview().inset(28)
//            $0.height.equalTo(72)
        }
        
        recommendBookLabel.snp.makeConstraints {
            $0.top.equalTo(introduceLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(21)
            $0.height.equalTo(24)
        }
        
        bookCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendBookLabel.snp.bottom).offset(21)
            $0.center.leading.trailing.equalToSuperview()
            $0.height.equalTo((Size.width - 64) / 3 * 1.5 + 1)
        }
        
        bookNameLabel.snp.makeConstraints {
            $0.top.equalTo(bookCollectionView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(21)
        }
        
        curationLabel.snp.makeConstraints {
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(bookNameLabel)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}
