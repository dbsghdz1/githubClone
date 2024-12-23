//
//  RepoTableViewModel.swift
//  githubClone
//
//  Created by 김윤홍 on 12/23/24.
//

import RxDataSources

struct RepoTableViewModelType {
    var items: [String]
}

extension RepoTableViewModelType: SectionModelType {
    
    init(original: RepoTableViewModelType, items: [String]) {
        self = original
        self.items = items
    }
    
    
}


