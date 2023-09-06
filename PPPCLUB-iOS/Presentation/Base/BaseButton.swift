//
//  BaseButton.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/13.
//

import UIKit

class BaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)

        let touchArea = bounds.insetBy(dx: -10, dy: -10)
        return touchArea.contains(point)
    }

    func configure() {}
    func bind() {}
}
