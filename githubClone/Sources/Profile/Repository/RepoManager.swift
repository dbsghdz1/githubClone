//
//  RepoManager.swift
//  githubClone
//
//  Created by 김윤홍 on 12/24/24.
//

import UIKit

import Moya
import RxSwift
import RxCocoa
import RxMoya

final class RepoManager {
    
    static let shared = RepoManager()
    
    private init() {}
    
    private let provider = MoyaProvider<RepoAPI>()
    
    func createRepo(repoName: String) -> Observable<RepoModelElement> {
        return provider.rx.request(.createRepo(name: repoName))
            .map(RepoModelElement.self)
            .asObservable()
    }
    
    func readRepo() -> Observable<RepoModel> {
        return provider.rx.request(.readRepo)
            .map(RepoModel.self)
            .asObservable()
    }
    
    func updateRepo() {
        
    }
    
    func deleteRepo(owner: String, repo: String) -> Observable<Void> {
        return provider.rx.request(.deleteRepo(owner: owner, repo: repo))
            .map { response -> () in }
            .asObservable()
    }
}

