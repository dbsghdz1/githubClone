//
//  ApiList.swift
//  githubClone
//
//  Created by 김윤홍 on 12/21/24.
//

import Moya
import Foundation

enum UserAPI {
    case login
    case getAccessToken(code: String)
}

extension UserAPI: TargetType {
    var baseURL: URL { URL(string: "https://github.com")! }
    
    var path: String {
        switch self {
        case .login: return ApiPath.login.path
        case .getAccessToken: return ApiPath.accessToken.path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login : return .get
        case .getAccessToken : return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login: return .requestPlain
        case .getAccessToken(let code):
            return .requestParameters(parameters: [
                "client_id": ApiPath.clientId,
                "client_secret": ApiPath.clientSecretId,
                "code": code
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login :
            return [:]
        case .getAccessToken :
            return ["Accept": "application/json"]
        }
    }
    
    var fullURL: String {
        return baseURL.absoluteString + ApiPath.login.path
    }
}
