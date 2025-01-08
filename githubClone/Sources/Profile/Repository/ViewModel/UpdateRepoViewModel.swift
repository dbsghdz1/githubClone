//
//  UpdateRepoViewModel.swift
//  githubClone
//
//  Created by 김윤홍 on 1/8/25.
//

import RxSwift
import RxCocoa

final class UpdateRepoViewModel: ViewModelType {

    struct Input {
        let repoDescription: Observable<String>
        let createButton: ControlEvent<Void>
        let repoName: Observable<String>
    }
    
    struct Output {
        let updatedData: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        //TODO: 아 왜 두번씩 실행될까
        let updateData = Observable
            .combineLatest(
                input.createButton,
                input.repoDescription,
                input.repoName
            )
            .flatMap { _, description, name in
                RepoManager.shared.updateRepo(owner: "HF-man", repo: name, description: description)
            }
            .asDriver(onErrorJustReturn:())
        
        return Output(updatedData: updateData)
    }
}
