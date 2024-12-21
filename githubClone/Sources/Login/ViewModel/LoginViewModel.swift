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
    private let disposeBag = DisposeBag()
    
    struct Input {
        let loginButtonTapEvent: ControlEvent<Void>
    }
    
    struct Output {
//        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
            input.loginButtonTapEvent
                .subscribe(onNext: { _ in
                    if let url = URL(string: "https://github.com/login/oauth/authorize"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        print("유효하지 않은 URL")
                    }
                })
                .disposed(by: disposeBag)
            
            return Output()
        }
}
