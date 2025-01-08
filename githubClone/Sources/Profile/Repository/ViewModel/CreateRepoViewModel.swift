//
//  CreateRepoViewModel.swift
//  githubClone
//
//  Created by 김윤홍 on 1/1/25.
//

import RxSwift
import RxCocoa

final class CreateRepoViewModel: ViewModelType {
    private let alertResult = PublishSubject<Bool>()
    
    struct Input {
        let createButtonTapped: ControlEvent<Void>
        let repoName: Observable<String>
    }
    
    struct Output {
        let showAlert: Observable<Void>
        let createResponse: Observable<RepoModelElement>
    }
    
    func transform(input: Input) -> Output {
        let showAlert = input.createButtonTapped
            .asObservable()
        
        let createResponse = alertResult
            .filter { $0 }
            .withLatestFrom(input.repoName)
            .flatMap { repoName in
                RepoManager.shared.createRepo(repoName: repoName)
            }
        
        return Output(
            showAlert: showAlert,
            createResponse: createResponse
        )
    }
    
    func streamAlert(result: Bool) {
        alertResult.onNext(result)
    }
}
