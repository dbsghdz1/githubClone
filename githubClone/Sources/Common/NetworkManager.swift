//
//  NetworkManager.swift
//  githubClone
//
//  Created by Yunhong on 3/19/25.
//

//여기를 어떻게 제네릭하게 사용할 수 있을까 httpMethod를 받아야 할것 같은데 + body와 header, path등...
//여기를 concurrency? 고민
import Foundation

import Moya
final class NetworkManager {
  private let provider = MoyaProvider<RepoAPI>()
  let userBearerToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
  
  static let shared = NetworkManager()
  private init() {}
  
  func requestPost(token: String) async throws -> AccessTokenModel {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "github.com"
    urlComponents.path = "/login/oauth/access_token"
    
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    
    let body = [
      "client_id": ApiPath.clientId,
      "client_secret": ApiPath.clientSecretId,
      "code": token
    ] as [String: Any]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
    } catch {
      print(error)
    }
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let accessToken = try JSONDecoder().decode(AccessTokenModel.self, from: data)
    return accessToken
  }
  
  func readRepo() async throws -> [RepoModelElement] {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.github.com"
    urlComponents.path = "/user/repos"
    
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = "GET"
    request.setValue("Bearer \(userBearerToken)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    print(self.userBearerToken)
    let (data, _) = try await URLSession.shared.data(for: request)
    let repoModel = try JSONDecoder().decode([RepoModelElement].self, from: data)
    return repoModel
  }
}
