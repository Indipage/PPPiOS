//
//  UIColor+.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1) {
        self.init(red: CGFloat(r)/255,green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: alpha)
    }
}

//MARK: - Custom Color

extension UIColor{
    
    class var pppMainPurple: UIColor {
        return UIColor(r: 170, g: 89, b: 252)
    }
    
    class var pppMainLightGreen: UIColor {
        return UIColor(r: 209, g: 252, b: 89)
    }
    
    class var pppWhite: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
    
    class var pppGrey1: UIColor {
        return UIColor(r: 248, g: 248, b: 248)
    }
    
    class var pppGrey2: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }
    
    class var pppGrey3: UIColor {
        return UIColor(r: 220, g: 220, b: 220)
    }
    
    class var pppGrey4: UIColor {
        return UIColor(r: 189, g: 189, b: 189)
    }
    
    class var pppGrey5: UIColor {
        return UIColor(r: 168, g: 168, b: 168)
    }
    
    class var pppGrey6: UIColor {
        return UIColor(r: 108, g: 108, b: 108)
    }
    
    class var pppGrey7: UIColor {
        return UIColor(r: 90, g: 90, b: 90)
    }
    
    class var pppGrey8: UIColor {
        return UIColor(r: 73, g: 73, b: 73)
    }
    
    class var pppGrey9: UIColor {
        return UIColor(r: 56, g: 56, b: 56)
    }
    
    class var pppBlack: UIColor {
        return UIColor(r: 34, g: 33, b: 36)
    }
    
    class var pppDimmed: UIColor {
        return UIColor(r: 0, g: 0, b: 0, alpha: 0.5)
    }
    
    
}
