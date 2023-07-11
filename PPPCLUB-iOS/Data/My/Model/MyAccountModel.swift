//
//  MyAccountModel.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/12.
//

struct MyAccountModel {
    var title: String
}

extension MyAccountModel {
    static func mockDummy() -> [MyInfoModel] {
        return [
            MyInfoModel(title: "로그아웃"),
            MyInfoModel(title: "탈퇴")
        ]
    }
}
