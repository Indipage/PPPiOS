////
////  PPPToastMessage.swift
////  PPPCLUB-iOS
////
////  Created by 류희재 on 2023/07/22.
////
//
//import UIKit
//import SnapKit
//import Then
//
//class PPPToastMessage: UIView {
//
//    //MARK: - Properties
//
//    private let padding: CGFloat = 28.adjusted
//
//    //MARK: - UI Components
//
//    private let toastMessageLabel = UILabel()
//    private lazy var toastButton = UIButton()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        style()
//        hierarchy()
//        layout()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func style() {
//        self.do {
//            $0.backgroundColor = .pppGrey9
//        }
//        toastMessageLabel.do {
//            $0.text = "티켓을 받았아요!"
//            $0.font = .pppBody4
//            $0.textColor = .pppWhite
//        }
//
//        toastButton.do {
//            $0.setTitle("티켓함 가기", for: .normal)
//            $0.setTitleColor(.pppMainLightGreen, for: .normal)
//
//        }
//    }
//
//    private func hierarchy() {
//        self.addSubviews(toastMessageLabel, toastButton)
//    }
//
//    private func layout() {
//        toastMessageLabel.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(20)
//            $0.centerY.equalToSuperview()
//        }
//
//        toastButton.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(20)
//            $0.centerY.equalToSuperview()
//            $0.width.equalTo(73)
//            $0.height.equalTo(22)
//        }
//    }
//
//    func show(in view: UIView, duration: TimeInterval = 2.0) {
//        view.addSubview(self)
//
//        self.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalToSuperview().offset(41)
//            $0.leading.greaterThanOrEqualToSuperview().offset(padding)
//            $0.trailing.lessThanOrEqualToSuperview().offset(-padding)
//        }
//
//        // Animation
//        alpha = 0
//        UIView.animate(withDuration: 0.3, animations: {
//            self.alpha = 1
//        }) { _ in
//            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//                self.hide()
//            }
//        }
//    }
//
//    private func hide() {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.alpha = 0
//        }) { _ in
//            self.removeFromSuperview()
//        }
//    }
//}
