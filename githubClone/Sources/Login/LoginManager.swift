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
    private let disposeBag = DisposeBag()
    
    func getRequest() -> Observable<Void> {
        provider.rx.request(.login)
        //operartor변경 아래도 마찬가지임 ?? request가 Single<Response> 타입??
            .map { _ in
                if let url = URL(string: UserAPI.login.fullURL), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            .asObservable()
    }
    
    func getAccessToken(code: String) -> Observable<Bool> {
        provider.rx.request(.getAccessToken(code: code))
            .map { response in
                let decoder = JSONDecoder()
                do {
                    let tokenResponse = try decoder.decode(AccessTokenModel.self, from: response.data)
                    UserDefaults.standard.set(tokenResponse.accessToken, forKey: "accessToken")
                    print("Access Token: \(tokenResponse.accessToken)")
                    return true
                } catch {
                    print("Access Token 디코딩 오류: \(error.localizedDescription)")
                    return false
                }
                
            }
            .asObservable()
    }
}
