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
    
    var introduceHeigth: Double = Double()
    var curationHeight: Double = Double()
    var introText: String = String()
    var isArticleExist = true {
        didSet {
            moveToArticleView.isHidden = !isArticleExist
            articleRequestView.isHidden = isArticleExist
        }
    }
    var model: Detail? {
        didSet {
            style()
            updateLayout()
        }
    }
    
    // MARK: - UI Components
    
    let detailTopView = DetailTopView()
    let ownerView = DetailOwnerView()
    let uniqueView = DetailUniqueView()
    lazy var articleRequestView = DetailArticleRequestView()
    lazy var moveToArticleView = DetailMoveToArticleView()
    private let contentView = UIView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        guard let model = model else { return }
        ownerView.do {
            $0.model = Detail(introduce: model.introduce, curation: model.curation)
        }
        
        moveToArticleView.do {
            $0.isHidden = !isArticleExist
        }
        
        articleRequestView.do {
            $0.isHidden = isArticleExist
        }
    }
    
    private func hieararchy() {
        self.addSubview(contentView)
        
        contentView.addSubviews(detailTopView,
                                ownerView,
                                uniqueView,
                                articleRequestView,
                                moveToArticleView
                                
        )
    }
    
    private func layout() {
        contentView.snp.makeConstraints {
            $0.edges.equalTo(self.contentLayoutGuide)
            $0.height.equalTo(self.frameLayoutGuide).priority(.low)
            $0.width.equalTo(self.frameLayoutGuide)
        }
        
        detailTopView.snp.makeConstraints {
            $0.top.width.leading.equalToSuperview()
            $0.height.equalTo(444.adjusted)
        }
        
        introduceHeigth = calculateTextViewHeight(
            text: model?.introduce ?? "",
            width: Size.width - 56.adjusted
        )
        
        curationHeight = calculateTextViewHeight(
            text: model?.curation ?? "",
            width: Size.width - 128.adjusted
        )
        
        ownerView.snp.makeConstraints {
            $0.top.equalTo(detailTopView.snp.bottom).offset(38.adjusted)
            $0.width.leading.equalToSuperview()
            $0.height.equalTo(introduceHeigth + curationHeight + 463)
        }
        
        uniqueView.snp.makeConstraints {
            $0.top.equalTo(ownerView.snp.bottom).offset(78.adjusted)
            $0.width.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(300.adjusted)
        }
        
        moveToArticleView.snp.makeConstraints {
            $0.top.equalTo(uniqueView.snp.bottom).offset(78.adjusted)
            
            $0.bottom.equalToSuperview().inset(250.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        
        articleRequestView.snp.makeConstraints {
            $0.top.equalTo(uniqueView.snp.bottom).offset(78)
            $0.width.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func updateLayout() {
        introduceHeigth = calculateTextViewHeight(
            text: model?.introduce ?? "",
            width: Size.width - 56.adjusted
        )
        
        curationHeight = calculateTextViewHeight(
            text: model?.curation ?? "",
            width: Size.width - 128.adjusted
        )
        
        ownerView.snp.updateConstraints {
            $0.top.equalTo(detailTopView.snp.bottom).offset(38.adjusted)
            $0.width.leading.equalToSuperview()
            $0.height.equalTo(introduceHeigth + curationHeight + 463)
        }
        
        uniqueView.snp.updateConstraints {
            $0.top.equalTo(ownerView.snp.bottom).offset(78.adjusted)
            $0.width.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(300.adjusted)
        }
        
        moveToArticleView.snp.updateConstraints {
            $0.top.equalTo(uniqueView.snp.bottom).offset(78.adjusted)
            $0.bottom.equalToSuperview().inset(280.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        
        articleRequestView.snp.updateConstraints {
            $0.top.equalTo(uniqueView.snp.bottom).offset(78)
            $0.width.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
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
    
    func introDataBind(introduce: String) {
        model = Detail(introduce: introduce, curation: "")
        introText = introduce
    }
    
    func curationDataBind(curation: String) {
        model = Detail(introduce: introText, curation: curation)
    }
}
