//
//  UITextView+.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/13.
//

import UIKit

extension UITextView {
    func setLineAndLetterSpacing(_ text: String, _ spacing: CGFloat){
        let style = NSMutableParagraphStyle()
        // 행간 세팅
        style.lineSpacing = spacing
        let attributedString = NSMutableAttributedString(string: text)
        // 자간 세팅
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(0), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
    
    func setAttribute(
        _ text: String,
        font: UIFont,
        color: UIColor,
        spacing: CGFloat? = nil,
        kern: CGFloat? = nil,
        align: NSTextAlignment? = .left) {
            
        var attribute: [NSAttributedString.Key: Any] = [:]
        attribute[.font] = font
        attribute[.foregroundColor] = color
        if let kern = kern {
            attribute[.kern] = kern
        }
        
        if let spacing = spacing {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = spacing
            style.alignment = align ?? .left
            attribute[.paragraphStyle] = style
        }
        
        let attributedString = NSAttributedString(
            string: text,
            attributes: attribute
        )

        self.attributedText = attributedString
    }
}
