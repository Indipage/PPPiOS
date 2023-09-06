//
//  OnboardingAgreementModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/09/05.
//

import Foundation

struct OnboardingAgreementModel {
    var title: String
    var isSelected: Bool
}

extension OnboardingAgreementModel {
    static func mockDummy() -> [OnboardingAgreementModel] {
        return [
            OnboardingAgreementModel(title: "만 14세 이상입니다.", isSelected: false),
            OnboardingAgreementModel(title: "(필수) 서비스 이용약관", isSelected: false),
            OnboardingAgreementModel(title: "(필수) 개인정보 처리방침침", isSelected: false),
            OnboardingAgreementModel(title: "(선택) 마케팅 정보 수신동의", isSelected: false)
        ]
    }
}
