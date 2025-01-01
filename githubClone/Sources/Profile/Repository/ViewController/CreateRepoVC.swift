//
//  CreateRepoVC.swift
//  githubClone
//
//  Created by 김윤홍 on 12/25/24.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift
import Then

final class CreateRepoVC: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var button = UIButton().then { button in
        button.setTitle("레포만들기", for: .normal)
        button.backgroundColor = .green
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindUI()
    }
    
    private func configureUI() {
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
    
}

extension CreateRepoVC {
    
    private func bindUI() {
        button.rx.tap
            .subscribe(onNext: {
                RepoManager.shared.createRepo()
            }).disposed(by: disposeBag)
    }
}
