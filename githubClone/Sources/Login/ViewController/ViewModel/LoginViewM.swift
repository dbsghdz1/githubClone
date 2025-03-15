//
//  LoginViewM.swift
//  githubClone
//
//  Created by Yunhong on 3/15/25.
//

import Combine
import SwiftUI

final class LoginViewM {
  let publisher = "".publisher

  func getRequest() {
    if let url = URL(string: UserAPI.login.fullURL), UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
    }
  }
}
