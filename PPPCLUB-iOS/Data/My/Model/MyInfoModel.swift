//
//  MyInfoModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/12.
//

struct MyInfoModel {
    var title: String
}

extension MyInfoModel {
    static func mockDummy() -> [MyInfoModel] {
        return [
            MyInfoModel(title: "자주 묻는 질문"),
            MyInfoModel(title: "개인정보처리방침")
        ]
    }
}

