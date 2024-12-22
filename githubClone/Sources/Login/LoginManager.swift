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
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let tokenResponse = try decoder.decode(AccessTokenModel.self, from: response.data)
                        print("Access Token: \(tokenResponse.accessToken)")
                        UserDefaults.standard.set(tokenResponse.accessToken, forKey: "accessToken")
                        DispatchQueue.main.async { [weak self] in
                            let tabBarController = TabBarController()
                            tabBarController.selectedIndex = 0
                            self?.navigateToTabBarController(tabBarController: tabBarController)
                        }
                    } catch {
                        print("JSON 디코딩 오류: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    //TODO: 화면 넘겨주기 처리 고민 해볼것
    private func navigateToTabBarController(tabBarController: TabBarController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
}
