//
//  RepoTableViewCell.swift
//  githubClone
//
//  Created by 김윤홍 on 12/23/24.
//

import UIKit

import SnapKit
import Then

final class RepoTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel().then { label in
        label.text = "리포지토리"
    }
    
    private let descriptionLabel = UILabel().then { label in
        label.text = "리포지토리 설명"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        [
            titleLabel,
            descriptionLabel
        ].forEach { contentView.addSubview($0) }
        contentView.backgroundColor = .systemBackground
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    func configureUI(repoTableModel: RepoTableModel) {
        titleLabel.text = repoTableModel.repoName
        descriptionLabel.text = repoTableModel.repoDescription
    }
}
