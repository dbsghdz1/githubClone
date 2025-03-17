//
//  MyApp.swift
//  githubClone
//
//  Created by Yunhong on 3/16/25.
//

import SwiftUI

@main
struct MyApp: App {
  let viewModel = LoginViewM()
  var body: some Scene {
    WindowGroup {
      LoginView()
        .onOpenURL { url in
          if url.absoluteString.starts(with: "githubclone://") {
            if let githubCode = url.absoluteString.split(separator: "=").last.map({
              String($0)
            }) {
              viewModel.getToken(value: githubCode)
            }
          }
        }
    }
  }
}
