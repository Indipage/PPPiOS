//
//  UIColor+.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r)/255,green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
}

//MARK: - Custom Color

extension UIColor{
    
    class var pppGradient1: UIColor {
        return UIColor(r: 254, g: 133, b: 194)
    }
    
    class var pppGradient2: UIColor {
        return UIColor(r: 253, g: 112, b: 95)
    }
    
    class var pppOrange: UIColor {
        return UIColor(r: 255, g: 77, b: 0)
    }
    
    class var pppMainPink: UIColor {
        return UIColor(r: 254, g: 109, b: 111)
    }
    
    class var pppSubPink1: UIColor {
        return UIColor(r: 254, g: 133, b: 191)
    }
    
    class var pppSubPink2: UIColor {
        return UIColor(r: 255, g: 253, b: 246)
    }
    
    class var pppWhite1: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
    
    class var pppWhite2: UIColor {
        return UIColor(r: 248, g: 248, b: 248)
    }
    
    class var pppWhite3: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }
    
    class var pppGrey1: UIColor {
        return UIColor(r: 90, g: 90, b: 90)
    }
    
    class var pppGrey2: UIColor {
        return UIColor(r: 73, g: 73, b: 73)
    }
    
    class var pppGrey3: UIColor {
        return UIColor(r: 56, g: 56, b: 56)
    }
    
    class var pppDarkGrey1: UIColor {
        return UIColor(r: 41, g: 41, b: 41)
    }
    
    
}
