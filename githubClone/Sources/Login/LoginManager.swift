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

final class LoginManager {
    
    static let shared = LoginManager()
    
    private init() {}
    
    private let provider = MoyaProvider<UserAPI>()
    
    func getRequest() -> Single<Void> {
        //operartor변경 아래도 마찬가지임 ?? request가 Single<Response> 타입??
        return Single.create { single in
            if let url = URL(string: UserAPI.login.fullURL), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                single(.success(()))
            } else {
                single(.failure(LoginError.invalidURL))
            }
            return Disposables.create()
        }
    }
    
    func getAccessToken(code: String) -> Observable<Bool> {
        provider.rx.request(.getAccessToken(code: code))
            .map(AccessTokenModel.self)
            .do(onSuccess: { model in
                UserDefaults.standard.set(model.accessToken, forKey: "accessToken")
            }, onError: { error in
                print(error.localizedDescription)
            })
            .map { _ in true }
            .catchAndReturn(false)
            .asObservable()
    }
}
