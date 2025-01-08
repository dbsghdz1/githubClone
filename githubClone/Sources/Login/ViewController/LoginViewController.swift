//
//  ViewController.swift
//  githubClone
//
//  Created by 김윤홍 on 12/15/24.
//

import UIKit

import RxCocoa
import RxSwift
import RxRelay
import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = LoginViewModel()
    
    private lazy var loginButton = UIButton().then { button in
        button.tintColor = .black
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.setTitle(loginMessage.loginButton.rawValue, for: .normal)
        button.backgroundColor = .black
    }
    
    private lazy var loginDescription = UILabel().then { label in
        label.text = loginMessage.loginDescription.rawValue
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
    }
    
    private lazy var gitHubLogoImage = UIImageView().then { imageView in
        imageView.image = .githubMark
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        [
            gitHubLogoImage,
            loginButton,
            loginDescription
        ].forEach { view.addSubview($0) }
        
        gitHubLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(75)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(gitHubLogoImage.snp.bottom).offset(250)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        
        loginDescription.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalTo(loginButton)
        }
    }
}

private extension LoginViewController {
    
    private func bindViewModel() {
        
        let input = LoginViewModel.Input(
            loginButtonTapEvent: loginButton.rx.tap
        )
        
        let output = self.viewModel.transform(input: input)
        
        output.loginResult
            .drive(onNext: { successLogin in
                if successLogin {
                    self.navigateToTabBarController()
                } else {
                    print("login실패")
                }
            }).disposed(by: disposeBag)
        
        output.accessToken
            .subscribe(onNext: {
                print("로긴 버튼눌림")
            }).disposed(by: disposeBag)
        
    }
    
    private func navigateToTabBarController() {
        let tabBarController = TabBarController()
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .compactMap({ $0.delegate as? SceneDelegate }).first,
           let window = sceneDelegate.window {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
}

//#Preview {
//    LoginViewController()
//}
