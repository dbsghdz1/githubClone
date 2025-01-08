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
    case createRepo(name: String)
    case readRepo
    case updateRepo(owner: String, repo: String, description: String)
    case deleteRepo(owner: String, repo: String)
}

extension RepoAPI: TargetType {
    var baseURL: URL { URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
            case .createRepo: return "/user/repos"
            case .readRepo: return "/user/repos"
            case .updateRepo(let owner, let repo, _): return "/repos/\(owner)/\(repo)"
            case .deleteRepo(let owner, let repo): return "/repos/\(owner)/\(repo)"
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
            case .createRepo(let name):
                let parameters: [String: Any] = [
                    "name" : name,
                ]
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            case .readRepo:
                return .requestPlain
            case .updateRepo(_, _, let description):
                let parameters: [String: Any] = [
                    "description" : description
                ]
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
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
}
