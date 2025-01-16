//
//  UpdateRepo.swift
//  githubClone
//
//  Created by 김윤홍 on 1/8/25.
//

import UIKit

import RxSwift
import RxCocoa
import Then
import SnapKit

final class UpdateRepoVC: UIViewController {
    
    private let viewModel: UpdateRepoViewModel
    private var disposeBag = DisposeBag()
    private let repoDescirption = UITextField()
    
    init(viewModel: UpdateRepoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bindUI()
    }
    
    private let editButton = UIButton().then { button in
        button.setTitle("수정하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
    }

    private func configureUI(updateModel: UpdateRepoModel) {
        [repoDescirption, editButton].forEach { view.addSubview($0) }
        repoDescirption.placeholder =  updateModel.placeHolder
        navigationItem.title = updateModel.naviTitle
        
        repoDescirption.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.height.equalTo(300)
        }
        
        editButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(repoDescirption)
            make.top.equalTo(repoDescirption.snp.bottom).offset(50)
            make.bottom.equalToSuperview()
        }
    }
}

extension UpdateRepoVC {
    
    private func bindUI() {
        
        let input = UpdateRepoViewModel.Input(
            viewDidLoadEvent: Observable.just(()),
            repoDescription: repoDescirption.rx.text.orEmpty.asObservable(),
            editButton: editButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.viewDidLoad
            .drive(onNext: { [weak self] repoData in
                guard let self else { return }
                let updateModel = UpdateRepoModel(
                    naviTitle: repoData.name,
                    placeHolder: repoData.description
                )
                self.configureUI(updateModel: updateModel)
            }).disposed(by: disposeBag)
        
        output.updatedData
            .drive(onNext: { [weak self] in
                guard let self else { return }
                RepoViewController().didPop.accept(true)
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
}
