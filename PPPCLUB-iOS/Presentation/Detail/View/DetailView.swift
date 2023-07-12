//
//  DetailView.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class DetailView: UIScrollView {
    
    // MARK: - Properties
    
    private let isArticleExist = false
    
    // MARK: - UI Components
    
    let detailTopView = DetailTopView()
    let ownerView = DetailOwnerView()
    private let uniqueView = DetailUniqueView()
    private let articleRequestView = DetailArticleRequestView()
    private let moveToArticleView = DetailMoveToArticleView()
    
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
        ownerView.do {
            $0.frame.size = $0.intrinsicContentSize
        }
    }
    
    private func hieararchy() {
        
        if isArticleExist {
            self.addSubviews(detailTopView,
                             ownerView,
                             uniqueView,
                             moveToArticleView
            )
        } else {
            self.addSubviews(detailTopView,
                             ownerView,
                             uniqueView,
                             articleRequestView
            )
        }
    }
    
    private func layout() {
        detailTopView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(381.0 / 821.0)
        }
        
        ownerView.snp.makeConstraints {
            $0.top.equalTo(detailTopView.snp.bottom)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(610.0 / 812.0)
        }
        
        // FIXME: - ownerView.curationLabel에 접근하지 않고 레이아웃 잡을 수 있는 방법 찾아보기
        uniqueView.snp.makeConstraints {
            $0.top.equalTo(ownerView.curationLabel.snp.bottom)
            $0.width.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        if isArticleExist {
            moveToArticleView.snp.makeConstraints {
                $0.top.equalTo(uniqueView.snp.bottom)
                $0.width.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.height.equalTo(344)
            }
        } else {
            articleRequestView.snp.makeConstraints {
                $0.top.equalTo(uniqueView.snp.bottom)
                $0.width.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.height.equalTo(277)
            }
        }
    }
}
