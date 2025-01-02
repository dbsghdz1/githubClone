//
//  CreateRepoViewModel.swift
//  githubClone
//
//  Created by 김윤홍 on 1/1/25.
//

import RxSwift
import RxCocoa

final class CreateRepoViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let createRepo: ControlEvent<Void>
    }
    
    struct Output {
        let createResponse: Observable<RepoModelElement>
    }
    
    
    func transform(input: Input) -> Output {
        let createResponse = input.createRepo
            .flatMap {
                RepoManager.shared.createRepo()
            }
        return Output(createResponse: createResponse)
    }
    
    
}
