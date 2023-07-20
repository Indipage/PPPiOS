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
    func tableViewCell(_ cell: UITableViewCell, addTarget target: Any?, action: Selector, for controlEvents: UIControl.Event)
}

class HomeArticleTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    var fullText: String?
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
    
    private func cellstyle() {
        
        selectionStyle = .none
        
        cellTitleLabel.do {
            $0.font = .pppSubHead1
            $0.textColor = .pppBlack
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }
        
        cellImageView.do {
            $0.backgroundColor = .blue
        }
        
        cellBodyLabel.do {
            $0.font = .pppBody5
            $0.textColor = .pppBlack
            $0.textAlignment = .left
            $0.numberOfLines = 0
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
        }
        
        cellImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cellBodyLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(28)
        }
    }
}

extension HomeArticleTableViewCell {
    
    internal func configureCell(article: ArticleBlockType) {
        switch article.keys.first {
        case .title:
            cellTitleLabel.isHidden = false
            cellImageView.isHidden = true
            cellBodyLabel.isHidden = true
            cellTitleLabel.text = article.values.first
        case .body:
            var bodyCompleteString = String()
            cellBodyLabel.isHidden = false
            cellTitleLabel.isHidden = true
            cellImageView.isHidden = true
            fullText = findBody(bodyFull: article.values.first ?? "")
            cellBodyLabel.text = fullText
            cellBodyLabel.setLineSpacing(spacing: 9)
            bodyInsideCheck(bodyArticle: article.values.first ?? "")
        case .img:
            print("이미지 왔당께요 \(article.values.first)")
            cellImageView.isHidden = false
            cellTitleLabel.isHidden = true
            cellBodyLabel.isHidden = true
            cellImageView.kfSetImage(url: article.values.first)
        case .none:
            break
        }
    }
}

enum BodyType: String {
    case link
    case color
    case bold
    case none
    
    func setLabelStyle(text: String) {
        switch self {
        case .link:
            print("\(text) link 입니다")
        case .color:
            print("\(text) color 입니다")
        case .bold:
            print("\(text) bold 입니다")
        case .none:
            print("\(text) 아무것도 아닙니다")
        }
    }
}

extension HomeArticleTableViewCell {
    
    func findBody(bodyFull: String) -> String {
        let bodyList = ["bold","color","link"]
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
        case "link":
            cellBodyLabel.asUnder(fullText: fullText, targetString: bodyContent, font: .pppBodyBold5, color: .pppMainPurple)
            
        case "bold":
            cellBodyLabel.asFont(fullText: fullText, targetString: bodyContent, font: .pppBodyBold5, spacing: 9, lineHeight: 9)
            
        case "color":
            cellBodyLabel.asFontColor(targetString: bodyContent, font: .pppBodyBold5, color: .pppMainPurple)
            
        default:
            break
        }
    }
    
    private func bodyInsideCheck(bodyArticle: String){
        
        var bodyString = bodyArticle
        let bodyList = ["color","bold","link"]
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
