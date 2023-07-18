//
//  NetworkResult.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import Foundation

enum NetworkResult<T> {
    case success(T)               // 서버 통신 성공했을 때,
    case requestErr(String)       // 요청 에러 발생했을 때,
    case notFoundErr(String,Int)
    case decodedErr               // 디코딩 오류 발생했을 때
    case pathErr                  // 경로 에러 발생했을 때,
    case serverErr                // 서버의 내부적 에러가 발생했을 때,
    case networkFail              // 네트워크 연결 실패했을 때
    case authorizationFail(T)        // 토큰 인증 오류
}

