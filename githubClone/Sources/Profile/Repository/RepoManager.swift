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
    private let disposeBag = DisposeBag()
    
    func createRepo() {
        
    }
    
    func readRepo() -> Observable<RepoModel> {
        return provider.rx.request(.readRepo)
            .map { response -> RepoModel in
                return try JSONDecoder().decode(RepoModel.self, from: response.data)
            }.asObservable()
    }
    
    func updateRepo() {
        
    }
    
    func deleteRepo() {
        
    }
}
