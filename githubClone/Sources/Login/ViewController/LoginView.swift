//
//  ViewController.swift
//  githubClone
//
//  Created by 김윤홍 on 12/15/24.
//

import UIKit
import SwiftUI
//로그인 에러처리 try catch
struct LoginView {
  @StateObject var viewModel: LoginViewModel
}

extension LoginView: View {
  var body: some View {
    if viewModel.accessToken.isEmpty {
      VStack {
        Spacer()
        Image(.githubMark)
          .resizable()
          .frame(width: 75, height: 75)
        Spacer()
        Button {
          viewModel.getRequest()
        } label: {
          Text(loginMessage.loginButton.rawValue)
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(.white)
            .font(.headline)
            .foregroundColor(.black)
            .cornerRadius(32)
            .overlay(
              RoundedRectangle(cornerRadius: 32)
                .stroke(Color(uiColor: .systemBackground), lineWidth: 1)
            )
        }
        .padding(.horizontal, 32)
        
        Text(loginMessage.loginDescription.rawValue)
          .font(.subheadline)
          .padding(.vertical, 8)
          .foregroundColor(.gray)
        Spacer()
      }
      .background(Color.black)
    } else {
      ProfileView()
    }
  }
}

#Preview {
  LoginView(viewModel: LoginViewModel())
}
