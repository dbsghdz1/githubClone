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
    var items: [MySectionData]
    
}

extension MySection {
    typealias Item = MySectionData
    
    init(original: MySection, items: [MySectionData]) {
        self = original
        self.items = items
    }
}

