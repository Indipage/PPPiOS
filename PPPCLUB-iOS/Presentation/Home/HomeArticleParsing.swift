//
//  HomeArticleParsing.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/17.
//

import UIKit

extension UIView {
    
    func HomeArticleParsing() {
        
        struct Body {
            var bold : String?
            var color : String?
            var click : String?
            var body : String?
        }
        
        var ArticleBody : Body = Body()
        var articleDummy = article
        
        var bodyType : String?
        var bodyContent : String?
        
        while articleDummy.count > 0 {
            
            bodyType = bodyCheck(text: articleDummy)
            bodyContent = bodyContentCheck(text: articleDummy, type: bodyType ?? "")
            
            if var bodyString = bodyContent {
                let bodyList = ["click","bold","color","body"]
                var _ : Int
                
                for i in 0...2 {
                    while bodyString.contains(bodyList[i]) == true {
                        bodyString = bodySplitParsing(text: bodyString, version: bodyList[i]) ?? ""
                    }
                }
                
                ArticleBody.body = bodyString
            }
            
        }
        
        func bodyCheck(text: String) -> String? {
            
            if let bodyStart = text.range(of: "<") {
                if let bodyEnd = text.range(of: ">") {
                    
                    let startStart = text[bodyStart].startIndex
                    let startEnd = text[bodyStart].endIndex
                    let endStart = text[bodyEnd].startIndex
                    let endEnd = text[bodyEnd].endIndex
                    
                    let articleDummyEnd = text.endIndex
                    let bodyChecked = text[startEnd ... endStart]
                    
                    var bodyTypeCheck = String(bodyChecked)
                    bodyTypeCheck = bodyTypeCheck.trimmingCharacters(in: ["<", ">"])
                    
                    articleDummy = String(text[endEnd ..< articleDummyEnd])
                    
                    return (bodyTypeCheck)
                    
                }
                else { return nil }
            }
            else { return nil }
        }
        
        func bodyContentCheck(text:String, type:String) -> (String)? {
            
            if let bodyStart = text.range(of: type) {
                let bodyEndRange = "<" + "/" + type + ">"
                if let bodyEnd = text.range(of: bodyEndRange) {
                    
                    let startStart = text[bodyStart].startIndex
                    let startEnd = text[bodyStart].endIndex
                    let endStart = text[bodyEnd].startIndex
                    let endEnd = text[bodyEnd].endIndex
                    let articleDummyEnd = text.endIndex
                    
                    let bodyChecked = text[text.startIndex ..< endStart]
                    let bodyContentChecked =  String(bodyChecked)
                    
                    articleDummy = String(text[endEnd ..< articleDummyEnd])
                    
                    return (bodyContentChecked)
                }
                else { return nil }
            }
            else { return nil }
        }
        
        func bodySplitParsing(text:String, version: String) -> (String)? {
            
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
                    
                    switch version {
                    case "click":
                        ArticleBody.click = splitTypeContent
                        print("⭐️version: \(version) content : \(splitTypeContent)")
                        
                    case "bold" :
                        ArticleBody.bold = splitTypeContent
                        print("⭐️version: \(version) content : \(splitTypeContent)")
                        
                    case "color" :
                        ArticleBody.color = splitTypeContent
                        print("⭐️version: \(version) content : \(splitTypeContent)")
                        
                    default:
                        splitTypeContent = ""
                    }
                    
                    var bodySplitContent = text.replacingOccurrences(of: splitContent, with: splitTypeContent)
                    
                    return (bodySplitContent)
                    
                }
                else { return nil }
            }
            else { return nil }
            
        }
    }
}
