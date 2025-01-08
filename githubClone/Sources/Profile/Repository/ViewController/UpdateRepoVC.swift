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
    
    private let viewModel = UpdateRepoViewModel()
    private var disposeBag = DisposeBag()
    private var repoModelElement: RepoModelElement
    private let repoDescirption = UITextField()
    var dataDelegate: SendDataDelegate?
    
    init(repoModelElement: RepoModelElement) {
        self.repoModelElement = repoModelElement
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = repoModelElement.fullName
         
        configureUI()
        bindUI()
    }
    
    private let editButton = UIButton().then { button in
        button.setTitle("수정하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
    }

    private func configureUI() {
        [repoDescirption, editButton].forEach { view.addSubview($0) }
        repoDescirption.placeholder = repoModelElement.description ?? ""
        
        repoDescirption.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        
        editButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(repoDescirption)
            make.top.equalTo(repoDescirption).offset(50)
            make.bottom.equalToSuperview()
        }
    }
}

private extension UpdateRepoVC {
    
    func bindUI() {
        
        let input = UpdateRepoViewModel.Input(
            repoDescription: repoDescirption.rx.text.orEmpty.asObservable(),
            createButton: editButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.updatedData
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                self.dataDelegate?.recieveData(response: repoDescirption.text ?? "", repoName: repoModelElement.name)
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
}
