//
//  HomeArticleParsing.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/17.
//

import UIKit

extension UIView {
    
    func HomeArticleParsing() {
        
        struct Article {
            var title = [String]()
            var image = [String]()
        }
        
        struct Body {
            var bold = [String]()
            var color = [String]()
            var click = [String]()
            var body = [String]()
        }
        
        var articleDummy = article
        
        var titleCnt : Int = 0
        var imgCnt : Int = 0
        var bodyCnt : Int = 0
        
        while articleDummy.count > 0 {
            
            var blockType : String?
            var blockContent : String?
            
            while blockType != "body" {
                
                var ArticleHead : Article = Article()
                var ArticleBody : Body = Body()
            
                blockType = bodyCheck(text: articleDummy)
                blockContent = bodyContentCheck(text: articleDummy, type: blockType ?? "")
                
                switch blockType {
                case "title":
                    titleCnt += 1
                case "img":
                    imgCnt += 1
                case "body":
                    bodyCnt += 1
                    
                default:
                    blockType = ""
                }
                
                if blockType != "body" {
                    if var bodyString = blockContent {
                        switch blockType {
                        case "title":
                            ArticleHead.title.append(bodyString)
                        case "img":
                            ArticleHead.image.append(bodyString)
                        default:
                            bodyString = ""
                        }
                    }
                }
                
                else if blockType == "body" {
                    if var bodyString = blockContent {
                        let bodyList = ["click","bold","color","body"]
                        var bodySplitType : String
                        var _ : Int
                        
                        for i in 0...2 {
                            while bodyString.contains(bodyList[i]) == true {
                                (bodyString, bodySplitType) = bodySplitParsing(text: bodyString, version: bodyList[i]) ?? "" as! (String, String)
                                
                                switch bodyList[i] {
                                case "click":
                                    ArticleBody.click.append(bodySplitType)
                                    
                                case "bold" :
                                    ArticleBody.bold.append(bodySplitType)
                                    
                                case "color" :
                                    ArticleBody.color.append(bodySplitType)
                                    
                                default:
                                    bodySplitType = ""
                                }
                            }
                        }
                        
                        ArticleBody.body.append(bodyString)
                        
                        print("body : \(ArticleBody.body)")
                        print("click : \(ArticleBody.click)")
                        print("bold : \(ArticleBody.bold)")
                        print("color : \(ArticleBody.color)")
                    }
                    
                }
                
                print("title : \(ArticleHead.title)")
                print("image : \(ArticleHead.image)")
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
            
            func bodySplitParsing(text:String, version: String) -> (String, String)? {
                
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
        
        print("titleCnt : \(titleCnt)")
        print("imgCnt : \(imgCnt)")
        print("bodyCnt : \(bodyCnt)")
    }
}
