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
    
    private let nameLabel = UILabel().then { label in
        label.text = "리포지토리"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(nameLabel)
        contentView.backgroundColor = .black
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
    }
}
