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
    
    func readRepo() -> RepoModel {
        var repo: [RepoModelElement]?
        provider.rx.request(.readRepo)
            .subscribe { result in
                switch result {
                case .success(let response):
                    do {
                        repo = try JSONDecoder().decode(RepoModel.self, from: response.data)
                        print("repo읽어오기 성공")
                    } catch {
                        print("repo JSON 디코딩 실패: \(error)")
                    }
                case .failure(let error):
                    print("repo 읽어오기  응답 실패\(error)")
                }
            }
            .disposed(by: disposeBag)
        return repo ?? []
    }
    
    func updateRepo() {
        
    }
    
    func deleteRepo() {
        
    }
}
