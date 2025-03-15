//
//  LoginViewModel.swift
//  githubClone
//
//  Created by 김윤홍 on 12/18/24.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa

final class LoginViewModel: ViewModelType {
//  let githubCodeObservable = SceneDelegate.githubCodeRelay.asObservable()
  let githubCodeObservable = Observable.just("")
  
  struct Input {
    let loginButtonTapEvent: ControlEvent<Void>
  }
  
  struct Output {
    let loginResult: Driver<Bool>
  }
  
  //TODO: transform 고민 해보기
  func transform(input: Input) -> Output {
    let loginResult = input.loginButtonTapEvent
      .flatMap {
        LoginManager.shared.getRequest()
          .asObservable()
          .flatMap { [weak self] _ in
            //여기서 보내는 Stringr값은 login하는 부분에서 받는 임시 code
            guard let self else { return Observable.just("") }
            return self.githubCodeObservable
          }
          .flatMap { code in
            LoginManager.shared.getAccessToken(code: code)
          }
      }
      .asDriver(onErrorJustReturn: false)
    return Output(loginResult: loginResult)
  }
}
