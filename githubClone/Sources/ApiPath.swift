//
//  ApiPath.swift
//  githubClone
//
//  Created by 김윤홍 on 12/21/24.
//

import Foundation

enum ApiPath {
    case login
    case accessToken
    case user
    case repos

    var path: String {
        switch self {
        case .login:
            return "/login/oauth/authorize?client_id=\(ApiPath.clientId)&scope=repo,user"
        case .accessToken:
            return "/login/oauth/access_token"
        case .user:
            return "/user"
        case .repos:
            return "/user/repos"
        }
    }
    
    //TODO: 호출시 매번 가져오는 것보다는 Splash에서 가져오는게 더 효과적
    //TODO: Tuist 설정을 해줘야 할 듯.. ? 
    static var clientId: String {
        guard let clientId = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String else {
            fatalError("CLIENT_ID를 찾을 수 없습니다.")
        }
        return clientId
    }
    
    static var clientSecretId: String {
        guard let clientSecretID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID_SECRET") as? String else {
            fatalError("CLIENT_ID를 찾을 수 없습니다.")
        }
        return clientSecretID
    }
}
