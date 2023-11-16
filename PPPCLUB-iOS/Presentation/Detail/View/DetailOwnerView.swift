//
//  DetailOwnerView.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

enum Const {
    static let itemSize = CGSize(width: 116, height: 156)
    static let itemSpacing = 32.0
    static var insetX: CGFloat {
        (Size.width - Self.itemSize.width) / 2
    }
    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
    }
}

final class DetailOwnerView: UIView {

    // MARK: - Properties

    var model: Detail? {
        didSet {
            guard let model = model else { return }
            style()
            updateLayout()
        }
    }
    var introText: String = String()
    
    // MARK: - UI Components

    private lazy var ownerIntroLabel = UILabel()
    private lazy var introduceTextView = UITextView(frame: CGRect(x: 0, y: 0, width: Size.width - 128, height: 0))
    let recommendBookLabel = UILabel()
    let flowLayout = UICollectionViewFlowLayout()
    lazy var bookCollectionView = UICollectionView(frame: .zero,
                                                           collectionViewLayout: flowLayout)
    lazy var bookNameLabel = UILabel()
    var curationTextView = UITextView(frame: CGRect(x: 0, y: 0, width: Size.width - 128, height: 0))

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
        ownerIntroLabel.do {
            $0.font = .pppSubHead1
            $0.textColor = .black
        }

        introduceTextView.do {
            $0.setAttribute(
                model.introduce,
                font: .pppBody5,
                color: .pppBlack,
                spacing: 10
            )

            $0.backgroundColor = .pppGrey2
            $0.textContainerInset = UIEdgeInsets(top: 14, left: 28, bottom: 0, right: 28)
            $0.textAlignment = .center
            $0.isEditable = false
            $0.isScrollEnabled = false
        }

        curationTextView.do {
            $0.setAttribute(
                model.curation,
                font: .pppBody5,
                color: .pppBlack,
                spacing: 10
            )

            $0.backgroundColor = .pppGrey2
            $0.textContainerInset = UIEdgeInsets(top: 14, left: 20, bottom: 0, right: 20)
            $0.textAlignment = .center
            $0.isEditable = false
            $0.isScrollEnabled = false
        }

        recommendBookLabel.do {
            $0.text = "공간지기 추천서가"
            $0.font = .pppSubHead1
            $0.textColor = .black
        }

        flowLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = Const.itemSpacing
            $0.itemSize = Const.itemSize
            $0.minimumInteritemSpacing = 0
        }

        bookCollectionView.do {
            $0.backgroundColor = .clear
            $0.clipsToBounds = true
            $0.isPagingEnabled = false
            $0.contentInsetAdjustmentBehavior = .never
            $0.contentInset = Const.collectionViewContentInset
            $0.decelerationRate = .fast
            $0.showsHorizontalScrollIndicator = false
        }

        bookNameLabel.do {
            $0.font = .pppBody1
            $0.textColor = .black
        }
    }

    private func hieararchy() {
        self.addSubviews(ownerIntroLabel,
                         introduceTextView,
                         recommendBookLabel,
                         bookCollectionView,
                         bookNameLabel,
                         curationTextView
        )
    }

    private func layout() {
        ownerIntroLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(28)
        }

        introduceTextView.snp.makeConstraints {
            $0.top.equalTo(ownerIntroLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }

        recommendBookLabel.snp.makeConstraints {
            $0.top.equalTo(introduceTextView.snp.bottom).offset(78)
            $0.leading.equalToSuperview().inset(21)
            $0.height.equalTo(28)
        }

        bookCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendBookLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(156)
        }

        bookNameLabel.snp.makeConstraints {
            $0.top.equalTo(bookCollectionView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(21)
        }

        curationTextView.snp.makeConstraints {
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(0)
        }
    }

    private func updateLayout() {
        guard let model = model else { return }
        introduceTextView.snp.updateConstraints {
            $0.height.equalTo(calculateTextViewHeight(text: model.introduce, width: Size.width - 56))
        }

        curationTextView.snp.updateConstraints {
            $0.height.equalTo(calculateTextViewHeight(text: model.curation, width: Size.width - 128))
        }
    }

    private func calculateTextViewHeight(text: String, width: CGFloat) -> CGFloat {
        let textView = UITextView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: width,
                height: 1)
        )
        textView.setAttribute(
            text,
            font: .pppBody5,
            color: .pppBlack,
            spacing: 10
        )
        return textView.contentSize.height + 14
    }
    
    func introDataBind(owner: String, introduce: String) {
        ownerIntroLabel.text = "공간지기 \(owner)"
        model = Detail(introduce: introduce, curation: "")
        introText = introduce
    }
    
    func curationDataBind(curation: String) {
        model = Detail(introduce: introText, curation: curation)
    }
}
