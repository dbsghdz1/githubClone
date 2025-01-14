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
    private var dataSource: RxTableViewSectionedReloadDataSource<MySection>?
    private let viewModel = RepoViewModel()
    //viewController 에 데이터 없이 section -> ViewModel 삭제 해야함
    private var sections = BehaviorRelay<[MySection]>(value: [])
    override func viewDidLoad() {
        configureUI()
        bindDataSource()
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

extension RepoViewController {
    
    private func bindDataSource() {
        let dataSource = RxTableViewSectionedReloadDataSource<MySection>(configureCell: {
            dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: RepoTableViewCell.self),
                for: indexPath
            ) as? RepoTableViewCell
            else { return UITableViewCell() }
            //구조 체 만들기
            cell.configureUI(title: item.name, description: item.description ?? "")
            return cell
        })
        self.dataSource = dataSource
    }
    
    private func bindUI() {
        
        let input = RepoViewModel.Input(
            viewDidLoadEvent: Observable.just(()),
            deleteTapEvent: repoTableView.rx.itemDeleted.asControlEvent(),
            repoPlusButtonTap: repoPlusButton.rx.tap.asControlEvent(),
            repoTableCellTap: repoTableView.rx.itemSelected.asControlEvent()
        )
        let output =  viewModel.transform(input: input)
        
        //TODO: tableViewData ViewModel에서 다루기 - 완
        output.repoData
            .drive(repoTableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)

        //TODO: 삭제시, 업데이트시 indexPath를 보내주고 viewModel에서 가공 후 View로 뿌려주기 + Alert 수정
        output.deleteData
            .drive(onNext: { [weak self] in
                guard let self else { return }
                let alertMessage = AlertMessage(title: "삭제 메시지", message: "잘 삭제 되었습니다.", yesButtonTitle: "네", cancelButtonTitle: nil, defaultButtonTitle: nil)
                showAlert(alertModel: alertMessage, Action: nil)
            }).disposed(by: disposeBag)
        
        output.repoPlusButtonTapped
            .drive(onNext: { [weak self] in
                guard let self else { return }
                let modal = RepoModalVC()
                modal.dataDelegate = self
                let naviModal = UINavigationController(rootViewController: modal)
                self.present(naviModal, animated: true)
            }).disposed(by: disposeBag)
        
        output.repoTableCellTapped
            .drive(onNext: { [weak self] repoData in
                guard let self else { return }
                let updateVC = UpdateRepoVC(repoModelElement: repoData)
                updateVC.dataDelegate = self
                self.navigationController?.pushViewController(updateVC, animated: true)
            }).disposed(by: disposeBag)
    }
}

