//
//  Untitled.swift
//  githubClone
//
//  Created by 김윤홍 on 12/24/24.
//

import Foundation

import RxCocoa
import RxSwift
import RxRelay

final class RepoViewModel: ViewModelType {
    
    struct Input {
        let viewDidLoadEvent: Observable<Void>
        let deleteTapEvent: Observable<String>
    }
    
    struct Output {
        let repoData: Driver<[RepoModelElement]>
        let deleteData: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let repoData = input.viewDidLoadEvent
            .flatMap { _ -> Observable<RepoModel> in
                return RepoManager.shared.readRepo()
            }
            .asDriver(onErrorJustReturn: [])
        
        let deleRepoData = input.deleteTapEvent
            .flatMap { repoName -> Observable<Void> in
                RepoManager.shared.deleteRepo(owner: "HF-man", repo: repoName)
            }
            .asDriver(onErrorJustReturn: ())
        return Output(repoData: repoData, deleteData: deleRepoData)
    }
}
