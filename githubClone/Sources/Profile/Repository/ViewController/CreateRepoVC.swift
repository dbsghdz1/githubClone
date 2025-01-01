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
    
    private var disposeBag = DisposeBag()
    private let viewModel = CreateRepoViewModel()
    
    private let button = UIButton().then { button in
        button.setTitle("레포만들기", for: .normal)
        button.backgroundColor = .black
        
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
        let input = CreateRepoViewModel.Input(createRepo: button.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        //TODO: 레포 생성 후 레포 읽어 오기?
        output.createResponse
            .subscribe(onNext: { response in
                print(response)
            }).disposed(by: disposeBag)
    }
}
