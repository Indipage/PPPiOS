//
//  HomeArticleTableViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/13.
//

import UIKit

import SnapKit
import Then

protocol TableViewCellDelegate: AnyObject {
    func tableViewCell(_ cell: UITableViewCell, addTarget target: Any?, action: Selector, for controlEvents: UIControl.Event)
}

class HomeArticleTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    weak var delegate: TableViewCellDelegate?
    private var cellTitleLabel = UILabel()
    private var cellImageView = UIImageView()
    private var cellBodyLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellstyle()
        hierarchy()
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 33, left: 0, bottom: 16, right: 16))
        //contentView.layoutIfNeeded()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Custom Method
    
    private func cellstyle() {
        
        selectionStyle = .none
        
        cellTitleLabel.do {
            $0.font = .pppSubHead1
            $0.textColor = .pppBlack
            $0.textAlignment = .left
            $0.numberOfLines = 0
//            $0.setLineSpacing(spacing: 28)
        }
        
        cellImageView.do {
            $0.backgroundColor = .blue
        }
        
        cellBodyLabel.do {
            $0.font = .pppBody5
            $0.textColor = .pppBlack
            $0.textAlignment = .left
            $0.numberOfLines = 0
//            $0.setLineSpacing(spacing: 24)
        }
        
    }
    
    private func hierarchy() {
        contentView.addSubviews(cellImageView, cellBodyLabel,cellTitleLabel)
    }
    
    private func layout() {
        
        cellTitleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(28)
////            $0.top.equalToSuperview().inset(30)
////            $0.centerX.equalToSuperview()
////            $0.leading.equalToSuperview().inset(20)
////            $0.bottom.equalToSuperview().inset(33)
//            $0.edges.equalToSuperview()
            
        }
        
        cellImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.top.equalToSuperview()
//            $0.width.equalToSuperview()
//            $0.height.equalToSuperview().inset(20)
        }
        
        cellBodyLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(28)
//            $0.top.equalToSuperview()
//            $0.centerX.equalToSuperview()
//            $0.leading.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview().inset(33)
        }
        
        
    }
}

extension HomeArticleTableViewCell {
    
    internal func configureCell(article: [String?]) {
        if let articleType = article[0] {
            if let articleContent = article[1]{
                switch articleType {
                case "title":
                    cellTitleLabel.isHidden = false
                    cellImageView.isHidden = true
                    cellBodyLabel.isHidden = true
                    cellTitleLabel.text = articleContent
                    cellTitleLabel.setLineSpacing(spacing: 500)
                    
                case "img":
                    print("이미지 왔당께요 \(articleContent)")
                    cellImageView.isHidden = false
                    cellTitleLabel.isHidden = true
                    cellBodyLabel.isHidden = true
                    cellImageView.kfSetImage(url: articleContent)
                    
                case "body":
                    var bodyCompleteString = String()
                    cellBodyLabel.isHidden = false
                    cellTitleLabel.isHidden = true
                    cellImageView.isHidden = true
                    cellTitleLabel.setLineSpacing(spacing: 100)
                    bodyCompleteString = findBody(bodyFull: articleContent)
                    cellBodyLabel.text = bodyCompleteString
                    bodyInsideCheck(bodyArticle: articleContent)
                    
                default:
                    break
                }
            }
        }
    }
}

extension HomeArticleTableViewCell {
    
    func findBody(bodyFull: String) -> String {
        let bodyList = ["bold","color","click"]
        var compeletBody : String = bodyFull
        var _ : Int

        for i in 0...2 {
            if compeletBody.contains(bodyList[i]) == true {
                let bodyStartRange = "<" + bodyList[i] + ">"
                let bodyEndRange = "<" + "/" + bodyList[i] + ">"
                
                compeletBody = compeletBody.replacingOccurrences(of: bodyEndRange, with: "")
                compeletBody = compeletBody.replacingOccurrences(of: bodyStartRange, with: "")

            }
        }
        return compeletBody
    }
    
    func changeBody(bodyType: String, bodyContent: String) {
        
        switch bodyType {
        case "click":
            cellBodyLabel.asUnder(targetString: bodyContent, font: .pppBodyBold5, color: .pppMainPurple)
            
        case "bold" :
            cellBodyLabel.asFont(targetString: bodyContent, font: .pppBodyBold5)
            
        case "color" :
            cellBodyLabel.setAttributeLabel(
                targetString: [bodyContent],
                color: .pppMainPurple,
                font:  .pppBodyBold5,
                spacing: 24
            )
            
        default:
            break
        }
    }
    
    private func bodyInsideCheck(bodyArticle: String){
        
        var bodyString = bodyArticle
        let bodyList = ["color","bold","click"]
        var bodySplitType : String
        var _ : Int

        for i in 0...2 {
            
            while bodyString.contains(bodyList[i]) == true {
                (bodyString, bodySplitType) = bodySplitParsing(text: bodyString, version: bodyList[i]) ?? "" as! (String, String)
                changeBody(bodyType: bodyList[i], bodyContent: bodySplitType)
                print("⭐️\(bodyList[i])    \(bodySplitType)")
            }
        }
    }
    
    private func bodySplitParsing(text:String, version: String) -> (String, String)? {
        
        let bodyStartRange = "<" + version + ">"
        let bodyEndRange = "<" + "/" + version + ">"
        
        if let bodyStart = text.range(of: bodyStartRange) {
            
            if let bodyEnd = text.range(of: bodyEndRange) {
                
                let startStart = text[bodyStart].startIndex
                let startEnd = text[bodyStart].endIndex
                let endStart = text[bodyEnd].startIndex
                let endEnd = text[bodyEnd].endIndex
                
                let bodyDummyEnd = text.endIndex
                
                let splitChecked = text[startStart ..< endEnd]
                var splitContent = String(splitChecked)
                var splitTypeContent =  String(splitChecked)
                
                splitTypeContent = splitTypeContent.replacingOccurrences(of: bodyEndRange, with: "")
                splitTypeContent = splitTypeContent.replacingOccurrences(of: bodyStartRange, with: "")
                
                var bodySplitContent = text.replacingOccurrences(of: splitContent, with: splitTypeContent)
                
                return (bodySplitContent, splitTypeContent)
                
            }
            else { return nil }
        }
        else { return nil }
    }
}
