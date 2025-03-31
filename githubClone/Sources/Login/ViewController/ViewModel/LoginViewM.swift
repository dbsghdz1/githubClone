//
//  LoginViewM.swift
//  githubClone
//
//  Created by Yunhong on 3/15/25.
//

import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
  
  @Published var accessToken = ""
  
  func getRequest() {
    if let url = URL(string: UserAPI.login.fullURL), UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
      //에러처리 하기
    }
  }
  
  @MainActor
  func getToken(token: String) async {
    do {
      accessToken = try await NetworkManager.shared.requestPost(token: token).accessToken
      UserDefaults.standard.set(accessToken, forKey: "accessToken")
    } catch {
      print(error)
    }
  }
  
}
