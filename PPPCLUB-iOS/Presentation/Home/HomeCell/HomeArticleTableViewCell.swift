//
//  HomeArticleTableViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/13.
//

import UIKit

import SnapKit
import Then

class HomeArticleTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    static let identifier = "HomeArticleTableViewCell"
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
            $0.textAlignment = .justified
            $0.numberOfLines = 0
        }
        
        cellBodyLabel.do {
            $0.font = .pppBody5
            $0.textColor = .pppBlack
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }
        
    }
    
    private func hierarchy() {
        contentView.addSubviews(cellTitleLabel, cellImageView, cellBodyLabel)
    }
    
    private func layout() {
        
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(33)
            
        }
        
        cellImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().inset(20)
        }
        
        cellBodyLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(33)
        }
        
        
    }
}

extension HomeArticleTableViewCell {
    
    internal func configureCell(article: [String?]) {
        if var articleType = article[0] {
            if var articleContent = article[1]{
                switch articleType {
                case "title":
                    cellTitleLabel.text = articleContent
                    cellTitleLabel.isHidden = false
                    cellImageView.isHidden = true
                    cellBodyLabel.isHidden = true
                    
                case "img":
                    cellImageView.kfSetImage(url: articleContent)
                    cellTitleLabel.isHidden = true
                    cellImageView.isHidden = false
                    cellBodyLabel.isHidden = true
                    
                case "body":
                    var bodyCompleteString = String()
                    bodyCompleteString = findBody(bodyFull: articleContent)
                    cellBodyLabel.text = bodyCompleteString
                    bodyInsideCheck(bodyArticle: articleContent)
                    cellTitleLabel.isHidden = true
                    cellImageView.isHidden = true
                    cellBodyLabel.isHidden = false
                    
                default:
                    break
                }
            }
        }
    }
}

extension HomeArticleTableViewCell {
    
    func findBody(bodyFull: String) -> String {
        let bodyList = ["click","bold","color"]
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
//            cellBodyLabel.asUnder(targetString: bodyContent)
            cellBodyLabel.asColor(targetString: bodyContent, color: .pppMainPurple)
            
        case "bold" :
            cellBodyLabel.asFont(targetString: bodyContent, font: .pppBodyBold5)
            
        case "color" :
            cellBodyLabel.asFontColor(targetString: bodyContent, font: .pppBodyBold5, color: .pppMainPurple)
            
        default:
            break
        }
    }
    
    private func bodyInsideCheck(bodyArticle: String){
        
        var bodyString = bodyArticle
        let bodyList = ["click","bold","color","body"]
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
