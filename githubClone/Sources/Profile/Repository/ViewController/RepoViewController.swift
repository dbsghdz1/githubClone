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

//TODO: BaseVC 활용하기
final class RepoViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<MySection>?
    private let viewModel = RepoViewModel()
    //viewController 에 데이터 없이 section -> ViewModel 삭제 해야함
    override func viewDidLoad() {
        configureUI()
        bindDataSource()
        bindUI()
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
            ) as? RepoTableViewCell else { return UITableViewCell() }
            //TODO: 구조 체 만들기
            let repoTableModel = RepoTableModel(
                repoName: item.name,
                repoDescription: item.description
            )
            cell.configureUI(repoTableModel: repoTableModel)
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
        
        //TODO: dataSource 저거 ! 처리고민해보쟈
        output.repoData
            .drive(repoTableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)

        //TODO: 삭제시, 업데이트시 indexPath를 보내주고 viewModel에서 가공 후 View로 뿌려주기 + Alert 수정, enum화
        output.deleteData
            .drive(onNext: { [weak self] in
                guard let self else { return }
                let alertMessage = AlertMessageModel(
                    title: AlertMessage.deleteTitle.rawValue,
                    message: AlertMessage.deleteMessage.rawValue,
                    yesButtonTitle: AlertMessage.deleteOk.rawValue,
                    cancelButtonTitle: nil,
                    defaultButtonTitle: nil
                )
                showAlert(alertModel: alertMessage, Action: nil)
            }).disposed(by: disposeBag)
        
        //고민: 모달띄우기, 네비전환 깔끔하게 처리할수 있을까? showAlert처럼 Ex활용해볼까/
        output.repoPlusButtonTapped
            .drive(onNext: { [weak self] in
                guard let self else { return }
                let naviModal = UINavigationController(rootViewController: RepoModalVC())
                self.present(naviModal, animated: true)
            }).disposed(by: disposeBag)
        
        output.repoTableCellTapped
            .drive(onNext: { [weak self] repoData in
                guard let self else { return }
                let updateVC = UpdateRepoVC(repoModelElement: repoData)
                self.navigationController?.pushViewController(updateVC, animated: true)
            }).disposed(by: disposeBag)
    }
}

