//
//  BaseAPI.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import Foundation

import Moya

class BaseAPI{
    public func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data)
        else {
            print("🚬 담배 마렵다 디코딩이 왜 안될까?")
            return .pathErr
        }
        
        switch statusCode {
        case 200..<205:
            guard decodedData.data != nil else {
                print("⛔️ \(self)애서 디코딩 오류가 발생했습니다 ⛔️")
                return .decodedErr
            }
            print("⭐️ 성공했습니다 ⭐️")
            return .success(decodedData.data as Any)
        case 400..<500:
            return .requestErr(decodedData.message ?? "요청에러")
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    func disposeNetwork<T: Codable>(_ result: Result<Response, MoyaError>, dataModel: T.Type, completion: @escaping (NetworkResult<Any>) -> Void) {
        switch result{
        case .success(let response):
            let statusCode = response.statusCode
            let data = response.data
            let networkResult = self.judgeStatus(by: statusCode, data, dataModel.self)
            
           completion(networkResult)
            
        case .failure(let err):
            print(err)
            
        }
    }
}
