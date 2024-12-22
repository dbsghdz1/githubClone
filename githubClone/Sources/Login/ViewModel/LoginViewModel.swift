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

final class LoginViewModel/*: ViewModelType*/ {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let loginButtonTapEvent: ControlEvent<Void>
    }
    
    //TODO: 화면 넘겨주기 
    struct Output {
    }
    
    func transform(input: Input) {
            input.loginButtonTapEvent
                .subscribe(onNext: { _ in
                    LoginManager.shared.getRequest()
                })
                .disposed(by: disposeBag)
        }
}
