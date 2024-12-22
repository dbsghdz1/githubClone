//
//  AccessTokenModel.swift
//  githubClone
//
//  Created by 김윤홍 on 12/22/24.
//

struct AccessTokenModel: Codable {
    let accessToken: String
    let tokenType: String
    let scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
    }
}
