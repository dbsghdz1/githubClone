//
//  NetworkManager.swift
//  githubClone
//
//  Created by Yunhong on 3/19/25.
//

import Foundation

final class NetworkManager {
  let userBearerToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
  
  static let shared = NetworkManager()
  private init() {}
  
  func requestPost(token: String) async throws -> AccessTokenModel {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "github.com"
    urlComponents.path = "/login/oauth/access_token"
    
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = HttpMethod.POST.rawValue
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
  
  func readRepo(userName: String) async throws -> [RepoModelElement] {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.github.com"
    urlComponents.path = "/users/userName/repos"
    
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = HttpMethod.GET.rawValue
    request.setValue("Bearer \(userBearerToken)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    let (data, _) = try await URLSession.shared.data(for: request)
    let repoModel = try JSONDecoder().decode([RepoModelElement].self, from: data)
    return repoModel
  }
  
  func getUserInfo() async throws -> User? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.github.com"
    urlComponents.path = "/user"
    
    guard let url = urlComponents.url else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = HttpMethod.GET.rawValue
    request.setValue("Bearer \(userBearerToken)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let user = try JSONDecoder().decode(User.self, from: data)
    return user
  }
}
