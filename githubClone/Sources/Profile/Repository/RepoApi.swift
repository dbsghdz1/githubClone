//
//  RepoApiList.swift
//  githubClone
//
//  Created by 김윤홍 on 12/24/24.
//

import Foundation

import Moya

let userBearerToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""

enum RepoAPI {
    case createRepo
    case readRepo
    case updateRepo
    case deleteRepo
}

extension RepoAPI: TargetType {
    var baseURL: URL { URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .createRepo: return "/user/repos"
        case .readRepo: return "/user/repos"
        case .updateRepo: return "/repos"
        case .deleteRepo: return "/repos/owner/repo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createRepo: return .post
        case .readRepo: return .get
        case .updateRepo: return .patch
        case .deleteRepo: return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
            //TODO: json으로 encoding 하는 방식을 깔끔하게 할 수 없을까??
        case .createRepo:
            let parameters: [String: Any] = [
                "name" : generateRandomName(),
                "description": "랜덤 이름 레포"
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .readRepo:
            return .requestPlain
        case .updateRepo: return .requestPlain
        case .deleteRepo: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .createRepo :
            return ["Authorization" : "Bearer \(userBearerToken)"]
        case .readRepo :
            return ["Authorization":  "Bearer \(userBearerToken)"]
        case .updateRepo :
            return ["Authorization" : "Bearer \(userBearerToken)"]
        case .deleteRepo :
            return ["Authorization" : "Bearer \(userBearerToken)"]
        }
    }
    
    func generateRandomName() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<8).compactMap { _ in characters.randomElement() })
    }
}
