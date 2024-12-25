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
    
    let nameLabel = UILabel().then { label in
        label.text = "리포지토리"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.addSubview(nameLabel)
        contentView.backgroundColor = .yellow
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureUI(text: String) {
        nameLabel.text = text
    }
}
