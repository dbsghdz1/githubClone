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
    let githubCodeObservable = SceneDelegate.githubCodeRelay.asObservable()
    
    struct Input {
        let loginButtonTapEvent: ControlEvent<Void>
    }
    
    struct Output {
        let accessToken: Observable<Void>
        let loginResult: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let loginRequest = input.loginButtonTapEvent
            .flatMap {
                LoginManager.shared.getRequest()
            }
        
        let loginResult = githubCodeObservable
            .flatMap { code in
                LoginManager.shared.getAccessToken(code: code)
            }
            .asDriver(onErrorJustReturn: false)
        
        return Output(accessToken: loginRequest, loginResult: loginResult)
    }
}
