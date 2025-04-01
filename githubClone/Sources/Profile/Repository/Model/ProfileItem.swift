//
//  ProfileItem.swift
//  githubClone
//
//  Created by Yunhong on 4/1/25.
//

import SwiftUI

struct ProfileItem: Hashable {
  let title: String
  let iconName: String
  let color: Color
  
  static let items: [ProfileItem] = [
    ProfileItem(title: "리포지토리", iconName: "book.closed", color: .gitRepoColor),
    ProfileItem(title: "별표 표시", iconName: "star", color: .gitStartColor),
    ProfileItem(title: "조직", iconName: "building.2", color: .gitOrgColor),
    ProfileItem(title: "프로젝트", iconName: "list.bullet.rectangle", color: .gitProjectColor)
  ]
}
