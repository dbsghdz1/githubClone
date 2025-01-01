//
//  Untitled.swift
//  githubClone
//
//  Created by 김윤홍 on 12/24/24.
//

import RxCocoa
import RxSwift

final class RepoViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()

    struct Input {
        let viewDidLoadEvent: Observable<Void>
    }
    
    struct Output {
        let repoData: Observable<RepoModel>
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoadEvent
            .subscribe(onNext: { _ in
            }).disposed(by: disposeBag)
        return Output(repoData: RepoManager.shared.readRepo())
    }
    
}
