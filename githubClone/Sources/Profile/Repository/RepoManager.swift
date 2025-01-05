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
    private var disposeBag = DisposeBag()
    
    func createRepo() -> Observable<RepoModelElement> {
        return provider.rx.request(.createRepo)
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
    
    func deleteRepo(owner: String, repo: String) {
        provider.rx.request(.deleteRepo(owner: owner, repo: repo))
            .subscribe({ result in
                switch result {
                case .success(let response):
                    if let responseString = String(data: response.data, encoding: .utf8) {
                        print("Response Body: \(responseString)")
                    } else {
                        print("No response body")
                    }
                    print("Response Headers: \(response.response?.allHeaderFields ?? [:])")
                case .failure(let error):
                    print(error)
                }
            }).disposed(by: disposeBag)
    }
}

