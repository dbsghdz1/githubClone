//
//  RepoViewController.swift
//  githubClone
//
//  Created by 김윤홍 on 12/22/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import RxDataSources

final class RepoViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var dataSource: RxTableViewSectionedReloadDataSource<MySection>?
    let viewModel = RepoViewModel()
    var sections = BehaviorRelay<[MySection]>(value: [])
    override func viewDidLoad() {
        configureUI()
        bindUI()
    }
    
    private lazy var repoTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        return tableView
    }()
    
    private func configureUI() {
        
        view.addSubview(repoTableView)
        
        repoTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension RepoViewController {
    
    private func bindUI() {
        dataSource = RxTableViewSectionedReloadDataSource<MySection>(configureCell: {
            dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: RepoTableViewCell.self),
                for: indexPath
            ) as? RepoTableViewCell
            else { return UITableViewCell() }
            cell.configureUI(title: item.name, description: item.description ?? "")
            return cell
        })
        
        //TODO: itemDelete action input에 추가하기 
        repoTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let self else { return }
                let selctedItem = self.sections.value[0].items[indexPath.row]
                RepoManager.shared.deleteRepo(owner: selctedItem.name, repo: selctedItem.name)
            }).disposed(by: disposeBag)
        
        self.sections
            .bind(to: repoTableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
        
        let input = RepoViewModel.Input(viewDidLoadEvent: Observable.just(()))
        let output =  viewModel.transform(input: input)
        
        //TODO: READ drive로 변경하기
        output.repoData
            .drive(onNext: { [weak self] repoModel in
                guard let self else { return }
                let newSections = [MySection(items: repoModel)]
                self.sections.accept(newSections)
            })
            .disposed(by: disposeBag)
    }
}
