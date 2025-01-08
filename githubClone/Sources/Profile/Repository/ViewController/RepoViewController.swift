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
import Then

protocol SendDataDelegate {
    func recieveData(response: String, repoName: String)
    func createRepoData(response: RepoModelElement)
}

final class RepoViewController: UIViewController, SendDataDelegate {
    
    private var disposeBag = DisposeBag()
    var dataSource: RxTableViewSectionedReloadDataSource<MySection>?
    private let viewModel = RepoViewModel()
    var sections = BehaviorRelay<[MySection]>(value: [])
    override func viewDidLoad() {
        configureUI()
        bindUI()
    }
    
    func createRepoData(response: RepoModelElement) {
        var currentSections = self.sections.value
        currentSections[0].items.append(response)
        self.sections.accept(currentSections)
    }
    
    func recieveData(response: String, repoName: String) {
        var currentSections = self.sections.value
        for (index, item) in currentSections[0].items.enumerated() {
            if item.name == repoName {
                currentSections[0].items[index].description = response
            }
        }
        self.sections.accept(currentSections)
    }
    
    private let repoTableView = UITableView().then { tableView in
        tableView.rowHeight = 100
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
    }
    
    private let repoPlusButton = UIBarButtonItem().then { button in
        button.image = UIImage(systemName: "plus")
    }
    
    private func configureUI() {
        
        view.addSubview(repoTableView)
        navigationItem.rightBarButtonItem = repoPlusButton
        
        repoTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

private extension RepoViewController {
    
    func bindUI() {
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
        
        repoPlusButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                let modal = RepoModalVC()
                modal.dataDelegate = self
                let naviModal = UINavigationController(rootViewController: modal)
                self.present(naviModal, animated: true)
            }).disposed(by: disposeBag)
        
        repoTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self else { return }
                let currentSections = self.sections.value
                let updateVC = UpdateRepoVC(repoModelElement: currentSections[0].items[indexPath.row])
                updateVC.dataDelegate = self
                self.navigationController?.pushViewController(updateVC, animated: true)
            }).disposed(by: disposeBag)
        
        self.sections
            .bind(to: repoTableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
        
        let deleteTapEvent = repoTableView.rx.itemDeleted
            .map { [weak self] indexPath -> String in
                guard let self else { return "" }
                var currentSections = self.sections.value
                let deletedItemName = currentSections[0].items[indexPath.row].name
                currentSections[0].items.remove(at: indexPath.row)
                self.sections.accept(currentSections)
                
                return deletedItemName
            }
            .filter { !$0.isEmpty }
        
        let input = RepoViewModel.Input(
            viewDidLoadEvent: Observable.just(()),
            deleteTapEvent: deleteTapEvent
        )
        let output =  viewModel.transform(input: input)
        
        //TODO: READ drive로 변경하기
        output.repoData
            .drive(onNext: { [weak self] repoModel in
                guard let self else { return }
                let newSections = [MySection(items: repoModel)]
                self.sections.accept(newSections)
            })
            .disposed(by: disposeBag)
        
        //TODO: 삭제잘되었다고 알럿 띄워주기
        output.deleteData
            .drive(onNext: { [weak self] in
                guard let self else { return }
                self.deleteAlert(title: "삭제", message: "삭제 잘되었습니다.")
            }).disposed(by: disposeBag)
    }
    
    func deleteAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmClicked = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmClicked)
        self.present(alert, animated: true)
    }
}

