//
//  ViewController.swift
//  githubClone
//
//  Created by 김윤홍 on 12/15/24.
//

import UIKit

import RxCocoa
import RxSwift
import Kingfisher
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
        button.setTitle("Github.com에 로그인", for: .normal)
        button.backgroundColor = .black
    }
    
    private lazy var loginDescription = UILabel().then { label in
        label.text = "계정을 사용하여 GitHub.com에 로그인"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
    }
    
    private lazy var gitHubLogoImage = UIImageView().then { imageView in
        imageView.image = UIImage(named: "github-mark")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        
        [
            self.gitHubLogoImage,
            self.loginButton,
            self.loginDescription
        ].forEach { self.view.addSubview($0) }
        
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
    func bindViewModel() {
        let input = LoginViewModel.Input(loginButtonTapEvent: self.loginButton.rx.tap)
        
        self.viewModel.transform(input: input)
        
    }
}

#Preview {
    LoginViewController()
}
