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

final class ArticleParsingManager {
    static let shared = ArticleParsingManager()
    var articleDummy: String = ""
    
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
}

