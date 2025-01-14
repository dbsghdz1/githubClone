//
//  UpdateRepoViewModel.swift
//  githubClone
//
//  Created by 김윤홍 on 1/8/25.
//

import RxSwift
import RxCocoa
import RxRelay

final class UpdateRepoViewModel: ViewModelType {
    
    private var repoData: BehaviorRelay<RepoModelElement>
    
    init(repoData: BehaviorRelay<RepoModelElement>) {
        self.repoData = repoData
    }

    struct Input {
        let viewDidLoadEvent: Observable<Void>
        let repoDescription: Observable<String>
        let editButton: ControlEvent<Void>
    }
    
    struct Output {
        let updatedData: Driver<Void>
        let viewDidLoad: Driver<RepoModelElement>
    }
    
    func transform(input: Input) -> Output {
        
        let viewDidLoad = input.viewDidLoadEvent
            .flatMap { [weak self] _ -> Observable<RepoModelElement> in
                guard let self else { return Observable.empty() }
                let data = self.repoData.value
                return Observable.just(data)
            }
            .asDriver { error in
                return Driver.empty()
            }
        /*TODO: 아 왜 두번씩 실행될까 - operator고민
         combineLatest - 두 개의 Observable의 각각의 이벤트가 발생할때 두 이벤트들의 마지막을 묶어서 전달 -> 2번씩실행
         withLatestform - 스킵되어도 되는 이벤트를 가진 Observable과 이벤트 처리의 중심이 되는 Observable과 같이 쓰면 유용 -> 고민
         merge -> 같은 타입의 이벤트를 발생하는 Observable을 합성하는 함수이다. 각각의 이벤트 수신가능 -> 테스트 해볼까?
         zip -> 두 Observable의 발생순서가 같아야한다 -> 실행시 description을 못받아옴
         combineLatest, join, merge, zip중에 어떤걸 써야할까?
         combineLatest를 쓰면 두번 실행되는 느낌? -> 이유 정리하기 일단 파악함
         필터링을 해볼까?
         두 개의 Observable 중 하나가 항목을 배출할 때 배출된 마지막 항목과 다른 한 Observable이 배출한 항목을 결합한 후 함수를 적용하여 실행 후 실행된 결과를 배출한다
         두 개이상의 Observable을 결합을 어떻게할까 stream이 궁금함 -> diagram 봐보쟈
         textField를 입력할때 debounce(마지막 값 전달)랑 throttle?
        */
        
        let updateData = Observable
            .combineLatest(input.editButton, input.repoDescription)
            .flatMap { _, description in
                let repoModelData = self.repoData.value
                return RepoManager.shared.updateRepo(
                    owner: repoModelData.owner.login,
                    repo: repoModelData.name,
                    description: description
                )
            }
            .asDriver(onErrorJustReturn: ())
        
        return Output(
            updatedData: updateData,
            viewDidLoad: viewDidLoad
        )
    }
}
