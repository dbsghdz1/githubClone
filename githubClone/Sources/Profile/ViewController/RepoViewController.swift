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
    
    var sections = BehaviorRelay(value: [
        MySection(items: [
            MySectionData(title: "12", description: "123"),
            MySectionData(title: "12", description: "123"),
            MySectionData(title: "12", description: "123"),
            MySectionData(title: "123232", description: "123")
        ])
    ])
    
    override func viewDidLoad() {
        configureUI()
        bindUI()
        
        self.sections
            .bind(to: repoTableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
    }
    
    private lazy var repoTableView: UITableView = {
        let tableView = UITableView()
        
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
            cell.nameLabel.text = item.title
            return cell
        })
    }
}

//#Preview {
//    RepoViewController()
//}
