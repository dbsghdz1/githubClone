//
//  RepoViewController.swift
//  githubClone
//
//  Created by 김윤홍 on 12/22/24.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

final class RepoViewController: UIViewController {
    
    override func viewDidLoad() {
        configureUI()
        bindUI()
    }
    
    private lazy var repoTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        tableView.backgroundColor = .red
        return tableView
    }()
    
    private func configureUI() {
        view.addSubview(repoTableView)
        
        repoTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
    }
    
}

extension RepoViewController {
    
    private func bindUI() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(
            configureCell: { [weak self] dataSource, tableView, indexPath, repo in
                guard let self else { return UITableViewCell() }
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self), for: indexPath) as? RepoTableViewCell else { return UITableViewCell() }
                cell.configureUI()
                return cell
            }
        )
    }
}

#Preview {
    RepoViewController()
}
