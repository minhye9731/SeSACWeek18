//
//  Endpoint.swift
//  SeSACWeek18
//
//  Created by 강민혜 on 11/2/22.
//

import Foundation
import Alamofire

enum SeSACAPI {
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
}

extension SeSACAPI {
    
    var url: URL {
        switch self {
        case .signup:
            return URL(string: "http://api.memolease.com/api/v1/users/signup")!
        case .login:
            return URL(string: "http://api.memolease.com/api/v1/users/login")!
        case .profile:
            return URL(string: "http://api.memolease.com/api/v1/users/me")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login: return ["Content-Type": "application/x-www-form-urlencoded"]
        case .profile: return [ "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)",
                                "Content-Type": "application/x-www-form-urlencoded" ]
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .signup(let userName, let email, let password):
            return [
                "userName": userName,
                "email": email,
                "password": password
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default: return nil
        }
    }
}










