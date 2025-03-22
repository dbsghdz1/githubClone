//
//  ViewController.swift
//  githubClone
//
//  Created by 김윤홍 on 12/15/24.
//

import UIKit
import SwiftUI
import Combine
//로그인 에러처리 try catch
struct LoginView: View {
  
  @StateObject var viewModel: LoginViewM
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
          Text("Github.com에 로그인")
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(.white)
            .font(.headline)
            .foregroundColor(.black)
            .cornerRadius(30)
            .overlay(
              RoundedRectangle(cornerRadius: 30)
                .stroke(Color(uiColor: .systemBackground), lineWidth: 1)
            )
        }
        .padding(.horizontal, 30)
        
        Text("계정을 사용하여 Github.com에 로그인")
          .font(.subheadline)
          .padding(.vertical, 5)
          .foregroundColor(.gray)
        Spacer()
      }
      .background(Color(uiColor: .systemBackground))
    } else {
      RepoView()
    }
  }
}

#Preview {
  LoginView(viewModel: LoginViewM())
}
