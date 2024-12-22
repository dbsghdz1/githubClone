//
//  LoginManager.swift
//  githubClone
//
//  Created by 김윤홍 on 12/21/24.
//

import UIKit

import Moya
import RxSwift
import RxCocoa
import RxMoya

class LoginManager {
    
    static let shared = LoginManager()
    
    private init() {}
    
    private let provider = MoyaProvider<UserAPI>()
    private let disposeBag = DisposeBag()
    
    func getRequest() {
        provider.rx.request(.login)
            .subscribe { result in
                switch result {
                case .success(let result):
                    if let url = URL(string: UserAPI.login.fullURL), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        print("로그인 버튼 응답성공: \(result)")
                    }
                case .failure(let error):
                    print("로그인 응답 실패 \(error)")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getAccessToken(code: String) {
        provider.rx.request(.getAccessToken(code: code))
            .subscribe { result in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
