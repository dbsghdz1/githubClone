//
//  Untitled.swift
//  githubClone
//
//  Created by Yunhong on 3/23/25.
//

import SwiftUI

extension Color {
  static let gitListColor = Color(hex: "#16181B")
  static let gitStatusColor = Color(hex: "#1F2124")
  static let gitRepoColor = Color(hex: "#41434D")
  static let gitStartColor = Color(hex: "#F6CD4B")
  static let gitOrgColor = Color(hex: "#F0914C")
  static let gitProjectColor = Color(hex: "#9295A0")
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
