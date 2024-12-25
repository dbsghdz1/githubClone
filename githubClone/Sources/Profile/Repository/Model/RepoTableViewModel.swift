//
//  RepoTableViewModel.swift
//  githubClone
//
//  Created by 김윤홍 on 12/23/24.
//

import RxDataSources

struct MySectionData {
    let title: String
    let description: String
}

struct MySection: SectionModelType {
    var items: [RepoModelElement]
    
}

extension MySection {
    typealias Item = RepoModelElement
    
    init(original: MySection, items: [RepoModelElement]) {
        self = original
        self.items = items
    }
}

