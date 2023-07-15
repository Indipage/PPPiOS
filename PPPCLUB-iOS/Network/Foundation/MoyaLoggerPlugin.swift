//
//  MoyaLoggerPlugin.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import Moya

final class MoyaLoggingPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        return request
    }
    // Request를 보낼 때 호출
    func willSend(_ request: RequestType, target: TargetType) {
        guard let httpRequest = request.request else {
            print("--> 유효하지 않은 요청")
            return
        }
        
        let url = httpRequest.description
        let method = httpRequest.httpMethod ?? "메소드값이 nil입니다."
        var log = """
                  ⎡---------------------서버통신을 시작합니다.----------------------⎤
                  [\(method)] \(url)
                  API: \(target) \n
                  """
        if let headers = httpRequest.allHTTPHeaderFields, !headers.isEmpty {
            log.append("header:\n \(headers) \n")
        }
        if let body = httpRequest.httpBody, let bodyString = String(bytes: body, encoding: String.Encoding.utf8) {
            log.append("\(bodyString)\n")
        }
        
        log.append("⎣------------------ Request END  -------------------------⎦")
        print(log)
    }
    // Response가 왔을 때
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            onSucceed(response, target: target, isFromError: false)
        case let .failure(error):
            onFail(error, target: target)
        }
    }
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        return result
    }
    
    func onSucceed(_ response: Response, target: TargetType, isFromError: Bool) {
        let request = response.request
        let url = request?.url?.absoluteString ?? "nil"
        let statusCode = response.statusCode
        var log = "⎡------------------서버에게 Response가 도착했습니다. ------------------⎤\n"
        log.append("API: \(target)\n")
        log.append("Status Code: [\(statusCode)]\n")
        log.append("URL: \(url)\n")
        if let responseData = String(bytes: response.data, encoding: String.Encoding.utf8) {
            log.append("Data: \n  \(responseData)\n")
        }
        log.append("⎣------------------ END HTTP (\(response.data.count)-byte body) ------------------⎦")
        print(log)
    }
    
    func onFail(_ error: MoyaError, target: TargetType) {
        if let response = error.response {
            onSucceed(response, target: target, isFromError: true)
            return
        }
        var log = "네트워크 오류"
        log.append("<-- \(error.errorCode) \(target)\n")
        log.append("\(error.failureReason ?? error.errorDescription ?? "unknown error")\n")
        log.append("<-- END HTTP")
        print(log)
    }
}
