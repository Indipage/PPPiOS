//
//  OnboardingInfoModel.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 10/30/23.
//

import UIKit

struct OnboardingInfoModel {
    var title: String
    var contnet: String
    var image : UIImage
}

extension OnboardingInfoModel {
    static func mockDummy() -> [OnboardingInfoModel] {
        return [
            OnboardingInfoModel(title: "Article", contnet: "책방지기가 들려주는 서점 이야기를 읽어보세요.\n매주 새로운 공간으로 여러분을 초대합니다.", image: Image.infoArticle),
            OnboardingInfoModel(title: "Ticket", contnet: "아티클을 읽고, 티켓을 받아요!\n티켓과 함께 공간으로 떠나보세요!", image: Image.infoPlace),
            OnboardingInfoModel(title: "Collection", contnet: "서점을 방문해, 공간을 직접 느껴보세요.\nQR 인증을 하고 시그니처 카드를 모아\n나만의 컬렉션을 꾸며봐요.", image: Image.infoCollection1),
            OnboardingInfoModel(title: "Place", contnet: "다양한 독립서점들을 둘러보며\n내 취향에 딱 맞는 공간을 찾아보세요.", image: Image.infoPlace),
            OnboardingInfoModel(title: "Welcome!", contnet: "책과 공간을 사랑하는\n당신을 위한 이야기", image: Image.infoWelcome)
        ]
    }
}

