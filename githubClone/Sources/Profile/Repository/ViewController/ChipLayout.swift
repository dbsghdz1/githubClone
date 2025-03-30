//
//  ChipLayout.swift
//  githubClone
//
//  Created by Yunhong on 3/22/25.
//

import SwiftUI

struct ChipLayout: Layout {
  
  var verticalSpacing: CGFloat
  var horizontalSpacing: CGFloat
  
  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    var totalHeigth: CGFloat = 0
    var currentRowWidth: CGFloat = 0
    var currentRowHeight: CGFloat = 0
    
    for view in subviews {
      let viewSize = view.sizeThatFits(.unspecified)
      
      if currentRowWidth + viewSize.width > (proposal.width ?? .infinity) {
        totalHeigth += currentRowWidth + verticalSpacing
        currentRowWidth = 0
        currentRowHeight = 0
      }
      currentRowWidth += viewSize.width + horizontalSpacing
      currentRowHeight = max(currentRowHeight, viewSize.height)
    }
    
    totalHeigth += currentRowHeight
    return CGSize(width: proposal.width ?? 0, height: totalHeigth)
  }
  
  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    var currentX: CGFloat = bounds.minX
    var currentY: CGFloat = bounds.minY
    var maxHeightInRow: CGFloat = 0
    
    for view in subviews {
      let viewSize = view.sizeThatFits(.unspecified)
      
      if currentX + viewSize.width > bounds.maxX {
        currentX = bounds.minX
        currentY += maxHeightInRow + verticalSpacing
        maxHeightInRow = 0
      }
      
      view.place(at: CGPoint(x: currentX, y: currentY), anchor: .topLeading, proposal: .unspecified)
      currentX += viewSize.width + horizontalSpacing
      maxHeightInRow = max(maxHeightInRow, viewSize.height)
    }
  }
}
