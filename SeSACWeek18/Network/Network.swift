//
//  Network.swift
//  SeSACWeek18
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation
import Alamofire

final class Network {
    
    static let share = Network()
    
    private init() { }
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod = .get, parameters: [String: String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                    
                case .success(let data):
                    completion(.success(data)) // 탈출클로저 + RESULT + 연관값 + 열거형 등이 쓰임
                case.failure(_):
                    
                    guard let statusCode = response.response?.statusCode else { return } // 진짜 에러 발생시 대응을 워해 return 하기전에 toast를 띄우거나 할 수도 있음
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    
                    completion(.failure(error))
                }
            }
 
    }
    
}
