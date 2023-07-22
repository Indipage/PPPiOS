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
    
    func setAttributeLabel(targetString: [String], color: UIColor?, font: UIFont?, spacing: CGFloat) {
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
    
    func asFont(fullText: String?, targetString: String, font: UIFont, spacing: CGFloat, lineHeight: CGFloat) {
        let fullText = fullText ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.font, value: font, range: range)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.minimumLineHeight = lineHeight
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: fullText.count))
        
        attributedText = attributedString
    }
    
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
    
    func asFontColor(fullText: String?, targetString: String, font: UIFont?, color: UIColor?, spacing: CGFloat, lineHeight: CGFloat) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.minimumLineHeight = lineHeight
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: fullText.count))
        
        attributedText = attributedString
    }
    
    func asUnder(fullText: String?, targetString: String, font: UIFont?, color: UIColor?, spacing: CGFloat, lineHeight: CGFloat) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.minimumLineHeight = lineHeight
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: fullText.count))
        
        attributedText = attributedString
    }
    
    func setupLabel(
        fullText: String?,
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
    
    func underLine(from text: String?, at range: String?) {
        guard let text = text,
              let range = range else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSString(string: text).range(of: range))
        self.attributedText = attributedString
    }
}



