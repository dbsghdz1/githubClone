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
    
    private var sections = BehaviorRelay<[MySection]>(value: [])
    
    struct Input {
        let viewDidLoadEvent: Observable<Void>
        let deleteTapEvent: ControlEvent<IndexPath>
        let repoPlusButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let repoData: Driver<[MySection]>
        let deleteData: Driver<Void>
        let repoPlusButtonTapped: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let repoData = input.viewDidLoadEvent
            .flatMap { _ -> Observable<RepoModel> in
                RepoManager.shared.readRepo()
            }
            .flatMap { [weak self] data -> Driver<[MySection]> in
                guard let self else { return Driver.just([MySection]()) }
                let newSections = [MySection(items: data)]
                self.sections.accept(newSections)
                return self.sections.asDriver(onErrorJustReturn: [MySection]())
            }
            .asDriver(onErrorJustReturn: [MySection]())
        
        let deleRepoData = input.deleteTapEvent
            .flatMap { [weak self] indexPath -> Observable<Void> in
                guard let self else { return Observable.just(()) }
                let item = self.sections.value[indexPath.section].items[indexPath.row]
                return RepoManager.shared.deleteRepo(owner: item.owner.login, repo: item.name)
            }
            .asDriver(onErrorJustReturn: ())
        
        let repoPlusButtonTapped = input.repoPlusButtonTap.asDriver()
        
    }
}
