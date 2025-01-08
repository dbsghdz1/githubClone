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
    
    private let viewModel = RepoViewModel()
    private var disposeBag = DisposeBag()
    private var repoModelElement: RepoModelElement
    private let repoDescirption = UITextField()
    
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

    private func configureUI() {
        view.addSubview(repoDescirption)
        repoDescirption.placeholder = repoModelElement.description ?? ""
        
        repoDescirption.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}

private extension UpdateRepoVC {
    
    func bindUI() {
        
        let input = 
    }
    
}
