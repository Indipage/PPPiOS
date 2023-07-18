//
//  UILabel+.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

extension UILabel {
    func asColor(targetString: String, color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        attributedText = attributedString
    }
    
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func setAttributeLabel(targetString: [String], color: UIColor?, spacing: CGFloat) {
        let fullText = text ?? ""
        let style = NSMutableParagraphStyle()
        let attributedString = NSMutableAttributedString(string: fullText)
        
        for target in targetString {
            let range = (fullText as NSString).range(of: target)
            attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        }
        
        style.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: style,
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
        
    }
    
    func asFont(targetString: String, font: UIFont) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.font, value: font, range: range)
        attributedText = attributedString
    }
    
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
    
    func asFontColor(targetString: String, font: UIFont?, color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        attributedText = attributedString
    }
    
    func asUnder(targetString: String) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle(rawValue: 1), range: range)
        attributedText = attributedString
    }
    
    func setupLabel(
            text: String,
            color: UIColor,
            font: UIFont,
            align: NSTextAlignment = .left,
            kern: Double? = 1.0,
            lineSpacing: CGFloat
        ) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.alignment = align
            
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttributes(
                [
                    .font: font,
                    .foregroundColor: color,
                    .kern: kern,
                    .paragraphStyle: paragraphStyle
                ],
                range: NSRange(location: 0, length: text.count)
            )
            
            self.attributedText = attributedString
        }
}



