//
//  CGPoint+.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/10.
//

import Foundation

internal extension CGPoint {
    
    // MARK: - CGPoint+offsetBy
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        var point = self
        point.x += dx
        point.y += dy
        return point
    }
}
