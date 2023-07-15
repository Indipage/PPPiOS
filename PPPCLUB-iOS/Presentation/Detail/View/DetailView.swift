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
    private final let introduce = "대전 성심당 부근 여행자에게 영감을 주는 여행 서점 겸 카페다. 서점은 2층에 있으며, 1층은 '도시여행자' 카페로 운영한다. 전시와 북토크, 심야책방을 정기적으로 연다. 책방지기는 이 공간에서 삶의 다양한 방향성을 제시하고자 한다. 도시문화 콘텐츠 기획을 겸하고 있다."
    private final let curation = "대전 성심당 부근 여행자에게 영감을 주는 여행 서점 겸 카페다. 서점은 2층에 있으며, 1층은 '도시여행자' 카페로 운영한다. 전시와 북토크, 심야책방을 정기적으로 연다. 책방지기는 이 공간에서 삶의 다양한 방향성을 제시하고자 한다. 도시문화 콘텐츠 기획을 겸하고 있다."
    
    // MARK: - UI Components
    
    let detailTopView = DetailTopView()
    let ownerView = DetailOwnerView()
    private let uniqueView = DetailUniqueView()
    let articleRequestView = DetailArticleRequestView()
    let moveToArticleView = DetailMoveToArticleView()
    private let contentView = UIView()
    
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
            $0.model = Detail(introduce: introduce, curation: curation)
        }
    }
    
    private func hieararchy() {
        
        self.addSubview(contentView)
        
        if isArticleExist {
            contentView.addSubviews(detailTopView,
                             ownerView,
                             uniqueView,
                             moveToArticleView
            )
        } else {
            contentView.addSubviews(detailTopView,
                             ownerView,
                             uniqueView,
                             articleRequestView
            )
        }
    }
    
    private func layout() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        detailTopView.snp.makeConstraints {
            $0.top.width.leading.equalToSuperview()
            $0.height.equalTo(444.adjusted)
        }
        
        let introduceHeigth = calculateTextViewHeight(
            text: introduce,
            width: Size.width - 56.adjusted
        )
        
        let curationHeight = calculateTextViewHeight(
            text: curation,
            width: Size.width - 128.adjusted
        )
        
        // FIXME: - 왜 477????????????????
        
        ownerView.snp.makeConstraints {
            $0.top.equalTo(detailTopView.snp.bottom).offset(38)
            $0.width.leading.equalToSuperview()
            $0.height.equalTo(introduceHeigth + curationHeight + 477)
        }
        
        uniqueView.snp.makeConstraints {
            $0.top.equalTo(ownerView.snp.bottom).offset(78)
            $0.width.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(300)
        }

        if isArticleExist {
            moveToArticleView.snp.makeConstraints {
                $0.top.equalTo(uniqueView.snp.bottom).offset(78)
                $0.width.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.height.equalTo(150)
            }
        } else {
            articleRequestView.snp.makeConstraints {
                $0.top.equalTo(uniqueView.snp.bottom).offset(78)
                $0.width.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.height.equalTo(216)
            }
        }
    }
    
    private func calculateCurationTextViewHeight(text: String) -> CGFloat {
        let textView = UITextView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: Size.width - 128,
                height: 1)
        )
        textView.setAttribute(text, font: .pppBody5, color: .pppBlack)
        return textView.contentSize.height
    }
    
    private func calculateIntroduceTextViewHeight(text: String) -> CGFloat {
        let textView = UITextView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: Size.width - 56,
                height: 1)
        )
        textView.setAttribute(text, font: .pppBody5, color: .pppBlack)
        return textView.contentSize.height
    }
    
    /// 위의 두 개를 합치면?
    private func calculateTextViewHeight(text: String, width: CGFloat) -> CGFloat {
        let textView = UITextView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: width,
                height: 30)
        )
        textView.setAttribute(text, font: .pppBody5, color: .pppBlack)

        return textView.contentSize.height + 28
    }
}
