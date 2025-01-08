//
//  RepoModalVC.swift
//  githubClone
//
//  Created by 김윤홍 on 1/5/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class RepoModalVC: UIViewController {
    
    private var disposeBag = DisposeBag()
    private let viewModel = CreateRepoViewModel()
    private let sheet = UIAlertController(title: "경고", message: "정말 휴지통으로 보내겠습니까?", preferredStyle: .alert)
    var dataDelegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        bindUI()
    }
    
    private let createRepoButton = UIButton().then { button in
        button.setTitle("만들기", for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
    
    private let repoName = UITextField().then { textfield in
        textfield.placeholder = "리포지토리 이름 입력"
    }
    
    private func configureUI() {
        let rightBarButtonItem = UIBarButtonItem(customView: createRepoButton)
        navigationItem.title = "새 레포 만들기"
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.addSubview(repoName)
        
        repoName.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}

private extension RepoModalVC {
    func bindUI() {
        
        let input = CreateRepoViewModel.Input(
            createButtonTapped: createRepoButton.rx.tap,
            repoName: repoName.rx.text.orEmpty.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        //TODO: alert을 띄워주기 dissmiss 후에 completion handler로 생성되었다는 것을 전달한 후에 레포를 읽어오는게 나을까?
        //아니면 viewWillAppear?
        
        output.showAlert
            .flatMap { [weak self] _ -> Observable<ActionType> in
                guard let self else { return .empty() }
                return self.showAlert(title: "레포 만들기", message: "정말 만드시겠습니까?")
            }
            .subscribe(onNext: { [weak self] actionType in
                guard let self else { return }
                switch actionType {
                    case .yes:
                        self.viewModel.streamAlert(result: true)
                    case .no:
                        self.viewModel.streamAlert(result: false)
                }
            }).disposed(by: disposeBag)
        
        output.createResponse
            .subscribe(onNext: { [weak self] response in
                print(response)
                guard let self else { return }
                self.dataDelegate?.createRepoData(response: response)
                //TODO: Response 보내기
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func showAlert(title: String, message: String) -> Observable<ActionType> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let yesClicked = UIAlertAction(title: "네", style: .default) { _ in
                observer.onNext(.yes)
                observer.onCompleted()
            }
            let noClicked = UIAlertAction(title: "아녀", style: .default) { _ in
                observer.onNext(.no)
                observer.onCompleted()
            }
            alert.addAction(yesClicked)
            alert.addAction(noClicked)
            self.present(alert, animated: true)
            
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}
