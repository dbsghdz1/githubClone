//
//  Untitled.swift
//  githubClone
//
//  Created by 김윤홍 on 12/24/24.
//

import RxCocoa
import RxSwift

final class RepoViewModel: ViewModelType {
    
    struct Input {
        let viewDidLoadEvent: Observable<Void>
    }
    
    struct Output {
        let repoData: Driver<[RepoModelElement]>
    }
    
    func transform(input: Input) -> Output {
        let repoData = input.viewDidLoadEvent
            .flatMap { _ -> Observable<RepoModel> in
                return RepoManager.shared.readRepo()
            }
            .asDriver(onErrorJustReturn: [])
        return Output(repoData: repoData)
    }
}
