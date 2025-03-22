//
//  MyApp.swift
//  githubClone
//
//  Created by Yunhong on 3/16/25.
//

import SwiftUI

@main
struct MyApp: App {
  
  @StateObject private var viewModel = LoginViewM()
  
  let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
  var body: some Scene {
    WindowGroup {
      if accessToken != "" {
        RepoView()
      } else {
        LoginView(viewModel: viewModel)
          .onOpenURL { url in
            if url.absoluteString.starts(with: "githubclone://") {
              if let githubCode = url.absoluteString.split(separator: "=").last.map({
                String($0)
              }) {
                Task {
                  await viewModel.getToken(token: githubCode)
                }
              }
            }
          }
      }
    }
  }
}
