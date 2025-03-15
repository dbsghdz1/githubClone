//
//  MyApp.swift
//  githubClone
//
//  Created by Yunhong on 3/16/25.
//

import SwiftUI

@main
struct MyApp: App {
  var body: some Scene {
    WindowGroup {
      LoginView()
        .onOpenURL { url in
          print(url)
        }
    }
  }
}
