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
    
    //ViewModel을 optional로 선언을 하면?
    //1.    viewModel이 외부에서 주입되고 주입되지 않을 가능성이 있는 경우. viewModel이 필요하지 않은 경우도 있는 경우.
    //2.    조건부 생성이 필요한 경우. viewModel이 필요하지 않은 경우도 있는 경우.
    //3.    테스트에서 유연성을 높이고 싶을 때. 테스트를 위해 viewModel 없이 LoginViewController를 초기화하고자 하는 경우.
    
    private var disposeBag = DisposeBag()
    private let viewModel = LoginViewModel()
    
    private let loginButton = UIButton().then { button in
        button.tintColor = .black
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.setTitle(loginMessage.loginButton.rawValue, for: .normal)
        button.backgroundColor = .black
    }
    
    private let loginDescription = UILabel().then { label in
        label.text = loginMessage.loginDescription.rawValue
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
    }
    
    private let gitHubLogoImage = UIImageView().then { imageView in
        imageView.image = .githubMark
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        //forEach관련해서 튜터님이 말씀하신게 있었는지 여쭤보기.. 까먹ㅇ므 ..
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

extension LoginViewController {
    
    private func bindViewModel() {
        
        let input = LoginViewModel.Input(
            loginButtonTapEvent: loginButton.rx.tap
        )
        
        let output = self.viewModel.transform(input: input)
        
        output.loginResult
            .drive(onNext: { [weak self] successLogin in
                guard let self else { return }
                if successLogin {
                    self.navigateToTabBarController()
                } else {
                    //TODO: login실패하면 alert이라도 띄워주기
                    print("login실패")
                }
            }).disposed(by: disposeBag)
    }
    
    private func navigateToTabBarController() {
//        let tabBarController = TabBarController()
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .compactMap({ $0.delegate as? SceneDelegate }).first,
           let window = sceneDelegate.window {
            window.rootViewController = UINavigationController(rootViewController: RepoViewController())
            window.makeKeyAndVisible()
        }
    }
}
