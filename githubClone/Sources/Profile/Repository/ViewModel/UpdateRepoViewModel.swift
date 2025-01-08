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
    }
    
    struct Output {
        let updatedData: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let updateData = input.createButton
            .withLatestFrom(input.repoDescription)
            .flatMap { description in
                RepoManager.shared.updateRepo(owner: "HF-man", repo: "HF-man", description: description)
            }
            .asDriver(onErrorJustReturn:())
        
        return Output(updatedData: updateData)
    }
}
