//
//  ArticleParsingManager.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/20.
//

import UIKit

enum ArticleType: String {
    case title
    case body
    case img
    case hr
    
    var font: UIFont? {
        switch self {
        case .title:
            return .pppSubHead1
        case .body:
            return .pppBody5
        case .img:
            return nil
        case .hr:
            return nil
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

final class ArticleParsingManager {
    static let shared = ArticleParsingManager()
    var articleDummy: String = ""
    var fullText: String = ""
    var linkText: String = ""
    
    func blockCheck(text: String) -> ArticleType? {
        var articleType: ArticleType?
        guard let bodyStart = text.range(of: "<") else { return nil }
        guard let bodyEnd = text.range(of: ">") else { return nil}
        
        let startEnd = text[bodyStart].endIndex
        let endStart = text[bodyEnd].startIndex
        let endEnd = text[bodyEnd].endIndex
        
        let articleDummyEnd = text.endIndex
        let bodyChecked = text[startEnd ... endStart]
        
        var bodyTypeCheck = String(bodyChecked)
        bodyTypeCheck = bodyTypeCheck.trimmingCharacters(in: ["<", ">"])
        
        switch bodyTypeCheck {
        case ArticleType.body.rawValue:
            articleType = .body
        case ArticleType.title.rawValue:
            articleType = .title
        case ArticleType.img.rawValue:
            articleType = .img
        case ArticleType.hr.rawValue:
            articleType = .hr
        default:
            break
        }
        
        articleDummy = String(text[endEnd ..< articleDummyEnd])
        
        return articleType
    }
    
    func blockContentCheck(text:String, type: ArticleType?) -> (String)? {
        guard text.range(of: type?.rawValue ?? "") != nil else { return nil}
        let bodyEndRange = "<" + "/" + (type?.rawValue)! + ">"
        guard let bodyEnd = text.range(of: bodyEndRange) else { return nil }
        
        let endStart = text[bodyEnd].startIndex
        let endEnd = text[bodyEnd].endIndex
        let articleDummyEnd = text.endIndex
        
        let bodyChecked = text[text.startIndex ..< endStart]
        let bodyContentChecked =  String(bodyChecked)
        
        articleDummy = String(text[endEnd ..< articleDummyEnd])
        
        return (bodyContentChecked)
    }
    
    func homeArticleParsing() -> [ArticleBlockType] {
        
        typealias ArticleBlockType = Dictionary<ArticleType,String>
        var parsingStored: [ArticleBlockType] = []
        
        
        while articleDummy.count > 0 {
            var blockType : ArticleType?
            var blockContent : String?
            
            while (blockType != .body) && articleDummy.count > 0 {
                
                
                blockType = blockCheck(text: articleDummy)
                blockContent = blockContentCheck(text: articleDummy, type: blockType)
                if let blockType = blockType, let blockContent = blockContent {
                    let articleBlock: ArticleBlockType = [blockType: blockContent]
                    parsingStored.append(articleBlock)
                }
            }
        }
        return parsingStored
    }
    
    func findBody(bodyFull: String) {
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
        self.fullText = compeletBody
    }
    
    func changeBody(targetLabel: UILabel, bodyType: String, bodyContent: String) {
        switch bodyType {
        case "link":
            self.linkText = bodyContent
            targetLabel.asUnder(fullText: fullText, targetString: bodyContent, font: .pppBodyBold5, color: .pppMainPurple)
            
        case "bold":
            targetLabel.asFont(fullText: fullText, targetString: bodyContent, font: .pppBodyBold5, spacing: 9, lineHeight: 9)
            
        case "color":
            targetLabel.asFontColor(fullText: fullText, targetString: bodyContent, font: .pppBodyBold5, color: .pppMainPurple, spacing: 8, lineHeight: 8)
            
        default:
            break
        }
    }
    
    func bodyInsideCheck(targetLabel: UILabel, bodyArticle: String){
        
        var bodyString = bodyArticle
        let bodyList = ["color","bold","link"]
        var bodySplitType : String
        var _ : Int
        
        for i in 0...2 {
            
            while bodyString.contains(bodyList[i]) == true {
                (bodyString, bodySplitType) = bodySplitParsing(text: bodyString, version: bodyList[i]) ?? ("","")
                changeBody(targetLabel: targetLabel, bodyType: bodyList[i], bodyContent: bodySplitType)
//                print("⭐️\(bodyList[i])    \(bodySplitType)")
            }
        }
    }
    
    private func bodySplitParsing(text:String, version: String) -> (String, String)? {
        
        let bodyStartRange = "<" + version + ">"
        let bodyEndRange = "<" + "/" + version + ">"
        
        guard let bodyStart = text.range(of: bodyStartRange) else { return nil}
        guard let bodyEnd = text.range(of: bodyEndRange) else { return nil}
        
        
        let startStart = text[bodyStart].startIndex
        let endEnd = text[bodyEnd].endIndex
        
        
        let splitChecked = text[startStart ..< endEnd]
        let splitContent = String(splitChecked)
        var splitTypeContent =  String(splitChecked)
        
        splitTypeContent = splitTypeContent.replacingOccurrences(of: bodyEndRange, with: "")
        splitTypeContent = splitTypeContent.replacingOccurrences(of: bodyStartRange, with: "")
        
        let bodySplitContent = text.replacingOccurrences(of: splitContent, with: splitTypeContent)
        
        return (bodySplitContent, splitTypeContent)
        
    }

}

