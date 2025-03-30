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
              .frame(alignment: .leading)
            Text(item.description ?? "")
         
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
