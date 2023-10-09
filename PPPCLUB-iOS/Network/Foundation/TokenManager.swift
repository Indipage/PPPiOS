//
//  TokenManager.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/10/09.
//

import UIKit

class TokenManager {
    
    static let shared = TokenManager()
    let defaults = UserDefaults.standard
    
    func isTokenExist() -> Bool {
        let token = defaults.string(forKey: "accessToken")
        if token != nil {
            return true
        } else {
            return false
        }
    }
    
    func saveToken(token: String) {
        defaults.set(token, forKey: "accessToken")
    }
    
    func getToken() -> String {
        return defaults.string(forKey: "accessToken") ?? ""
    }
    
    // MARK: - 로그아웃, 탈퇴 및 로그인 테스트시 사용
    
    func removeToken() {
        defaults.removeObject(forKey: "accessToken")
    }
    
}
