//
//  HomeArticleTableViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/13.
//

import UIKit

import SnapKit
import Then

typealias ArticleBlockType = Dictionary<ArticleType,String>

protocol TableViewCellDelegate: AnyObject {
    func pushDetailView()
}

class HomeArticleTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    var fullText: String?
    var linkText: String?
    
    // MARK: - UI Components
    
    weak var delegate: TableViewCellDelegate?
    private var cellTitleLabel = UILabel()
    private var cellImageView = UIImageView()
    private var cellBodyLabel = UILabel()
    private var cellUnderLine = UIView()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        gesture()
        
        cellstyle()
        hierarchy()
        layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellTitleLabel.font = .pppSubHead1
        cellTitleLabel.textColor = .pppBlack
        cellBodyLabel.font = .pppBody5
        cellBodyLabel.textColor = .pppBlack
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Custom Method
    
    private func gesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
        cellBodyLabel.isUserInteractionEnabled = true
        cellBodyLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func cellstyle() {
        
        selectionStyle = .none
        
        cellTitleLabel.do {
            $0.font = .pppSubHead1
            $0.textColor = .pppBlack
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }
        
        cellBodyLabel.do {
            $0.font = .pppBody5
            $0.textColor = .pppBlack
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }
        
        cellUnderLine.do {
            $0.backgroundColor = .pppGrey2
        }
        
    }
    
    private func hierarchy() {
        contentView.addSubviews(cellImageView, cellBodyLabel,cellTitleLabel,cellUnderLine)
    }
    
    private func layout() {
        cellBodyLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(28)
            $0.bottom.equalToSuperview().inset(30)
        }
        
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(28)
            $0.bottom.equalToSuperview().inset(30)
        }
        
        cellImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30)
        }
        
        cellUnderLine.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(1)
        }
    }
    
    //MARK: - Action Method
    
    @objc func handleLabelTap(_ recognizer: UITapGestureRecognizer) {
        handleTextInteraction(recognizer)
    }
}

extension HomeArticleTableViewCell {
    
    internal func configureCell(article: ArticleBlockType) {
        switch article.keys.first {
        case .title:
            cellTitleLabel.isHidden = false
            cellImageView.isHidden = true
            cellBodyLabel.isHidden = true
            cellUnderLine.isHidden = true
            cellTitleLabel.text = article.values.first
        case .body:
            cellBodyLabel.isHidden = false
            cellTitleLabel.isHidden = true
            cellImageView.isHidden = true
            ArticleParsingManager.shared.findBody(bodyFull: article.values.first ?? "")
            cellBodyLabel.text = ArticleParsingManager.shared.fullText
            cellBodyLabel.setLineSpacing(spacing: 9)
            ArticleParsingManager.shared.bodyInsideCheck(targetLabel: cellBodyLabel, bodyArticle: article.values.first ?? "")
            cellUnderLine.isHidden = true
        case .img:
            cellImageView.isHidden = false
            cellTitleLabel.isHidden = true
            cellBodyLabel.isHidden = true
            cellImageView.kfSetImage(url: article.values.first)
            cellUnderLine.isHidden = true
        case .hr:
            cellImageView.isHidden = true
            cellTitleLabel.isHidden = true
            cellBodyLabel.isHidden = true
            cellUnderLine.isHidden = false
        case .none:
            break
        }
    }
    
    func handleTextInteraction(_ recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: cellBodyLabel)
        let textStorage = NSTextStorage(attributedString: cellBodyLabel.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        // 클릭한 위치의 글자 인덱스를 찾기 위해 textContainer 사용
        let textContainer = NSTextContainer(size: cellBodyLabel.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        // 터치한 지점에 해당하는 글자의 인덱스를 가져옴
        let characterIndex = layoutManager.characterIndex(for: tapLocation, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        print("클릭한 특정 텍스트의 인덱스: \(characterIndex)")
        
        let labelText = cellBodyLabel.text
        let targetText = ArticleParsingManager.shared.linkText
        guard let labelText = labelText else { return }

        if let range = labelText.range(of: targetText) {
            let startIndex = labelText.distance(from: labelText.startIndex, to: range.lowerBound)
            let endIndex = labelText.distance(from: labelText.startIndex, to: range.upperBound)
            
            print("특정 텍스트가 있는 위치: \(startIndex) ~ \(endIndex)")
            if startIndex <= characterIndex && characterIndex <= endIndex {
                delegate?.pushDetailView()
            }
        }
        
    }
}
