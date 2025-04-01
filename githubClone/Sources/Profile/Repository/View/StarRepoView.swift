//
//  StarRepoView.swift
//  githubClone
//
//  Created by Yunhong on 4/1/25.
//

import SwiftUI

struct StarRepoview {
  @State private var repoModel: RepoModel?
  var gridItems: [GridItem] = [
    GridItem(.flexible())
  ]
  let user: User?
}

extension StarRepoview: View {
  var body: some View {
    ScrollView(.horizontal) {
      LazyHGrid(rows: gridItems) {
        ForEach(repoModel ?? []) { repo in
          GroupBox {
            VStack(alignment: .leading) {
              Text(repo.description ?? "")
              Spacer()
              HStack {
                Image(systemName: "star")
                  .foregroundStyle(Color.gray)
                Text("\(repo.stargazersCount)")
                if let language = repo.language {
                  Image(systemName: "circle.fill")
                    .foregroundStyle(Color.red)
                  Text("\(language.rawValue)")
                }
                Spacer()
              }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          } label: {
            HStack {
              AsyncImage(url: URL(string: user?.avatarURL ?? "")) { image in
                image.image?.resizable()
              }
              .frame(width: 25, height: 25, alignment: .leading)
              .clipShape(.circle)
              Text(user?.login ?? "")
                .foregroundStyle(Color.gray)
            }
          }
          .frame(width: 300, height: 200)
          .background(Color.gitListColor)
        }
      }
      .onAppear {
        Task {
          do {
            repoModel = try await NetworkManager.shared.readRepo(userName: user?.login ?? "")
          } catch {
            print(error.localizedDescription)
          }
        }
      }
    }
  }
}
