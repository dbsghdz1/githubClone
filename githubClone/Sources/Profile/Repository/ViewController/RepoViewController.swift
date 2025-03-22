//
//  RepoViewController.swift
//  githubClone
//
//  Created by 김윤홍 on 12/22/24.
//

import SwiftUI

struct RepoView: View {
  @State private var repoData: [RepoModelElement] = RepoModel()
  @State private var searchText = ""
  @State private var ex = ["유형", "언어", "정렬: 최근에 푸시됨(내림차순)"]
  
  var body: some View {
    VStack {
      NavigationStack {
        ChipLayout(verticalSpacing: 8, horizontalSpacing: 8) {
          ForEach(ex.indices, id: \.self) { index in
            let model = ex[index]
            Text(model)
              .padding(.horizontal, 12)
              .padding(.vertical, 5)
              .background(
                Capsule().foregroundStyle(.gray)
              )
          }
        }
        .padding(.leading, 16)
        List(repoData) { item in
          VStack(alignment: .leading) {
            Text(item.name)
              .fontWeight(.bold)
            //              .padding(.init(top: 0.0, leading: 0.0, bottom: 3.0, trailing: 0.0))
              .frame(alignment: .leading)
            if item.description != nil {
              Text(item.description ?? "")
            }
            HStack {
              Image(systemName: "star")
                .foregroundStyle(.gray)
              Text("\(item.stargazersCount)")
                .foregroundStyle(Color.gray)
              //Swift 경우에만 색상 -- 수정 필요 --
              Image(systemName: "circle.fill")
                .foregroundStyle(.red)
              Text(item.language?.rawValue ?? "")
            }
          }
        }
        .contentMargins(0, for: .scrollContent)
        .navigationTitle("리포지토리")
        .navigationBarTitleDisplayMode(.inline)
      }
      .searchable(
        text: $searchText,
        placement: .navigationBarDrawer(displayMode: .always),
        prompt: "검색"
      )
      .onSubmit(of: .search) {
        print(searchText)
      }
    }
    .onAppear {
      Task {
        do {
          repoData = try await NetworkManager.shared.readRepo()
        } catch {
          print(error)
        }
      }
    }
  }
}
#Preview {
  RepoView()
}

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
