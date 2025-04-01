//
//  ProfileView.swift
//  githubClone
//
//  Created by Yunhong on 3/22/25.
//

import SwiftUI

struct ProfileView {
  @State private var user: User?
  private var gridItems: [GridItem] = [
    GridItem(.flexible())
  ]
}

extension ProfileView: View {
  var body: some View {
    ScrollView {
      VStack {
        HStack {
          Spacer()
          Image(systemName: "gearshape")
            .imageScale(.large)
            .foregroundStyle(.blue)
            .font(.headline)
            .padding(.trailing, 16)
          Image(systemName: "square.and.arrow.up")
            .imageScale(.large)
            .foregroundStyle(.blue)
            .font(.headline)
        }
        .padding(.horizontal)
        HStack {
          AsyncImage(url: URL(string: user?.avatarURL ?? "")) { result in
            result.image?
              .resizable()
              .scaledToFill()
          }
          .frame(width: 75, height: 75)
          .clipShape(.circle)
          VStack {
            Text(user?.name ?? "")
              .font(.title2)
              .fontWeight(.bold)
            Text(user?.login ?? "")
              .font(.subheadline)
              .foregroundStyle(.gray)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        Button {
        } label: {
          Text(" 🤔")
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 50)
            .background(Color.gitStatusColor)
            .foregroundColor(.white)
            .cornerRadius(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color(uiColor: .systemBackground), lineWidth: 1)
            )
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        HStack {
          Image(systemName: "person.2")
            .foregroundStyle(.gray)
          Text("\(user?.followers ?? 0) 팔로워")
          Text("·")
          Text("\(user?.following ?? 0) 팔로우하는 중")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 8)
        .padding(.vertical)
        VStack(spacing: 0) {
          ForEach(ProfileItem.items, id: \.self) { item in
            HStack {
              Image(systemName: item.iconName)
                .frame(width: 20, height: 20)
                .padding(.all, 8)
                .background(item.color)
                .clipShape(RoundedRectangle(cornerRadius: 5))
              Text(item.title)
                .padding(.leading, 8)
              Spacer()
            }
            .padding(.all)
            if item.title != ProfileItem.items.last?.title {
              Divider()
            }
          }
          .listStyle(.automatic)
          .background(Color.gitListColor)
          .frame(maxWidth: .infinity)
          .ignoresSafeArea(edges: .horizontal)
        }
        HStack {
          Image(systemName: "star")
            .padding(.trailing)
            .foregroundStyle(.gray)
          Text("인기")
            .foregroundStyle(.gray)
          Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
        if let user = user {
            StarRepoview(user: user)
        }
      }
      .onAppear {
        Task {
          do {
            guard
              let userModel = try await NetworkManager.shared.getUserInfo()
            else { return }
            user = userModel
          } catch {
            print(error)
          }
        }
      }
    }
  }
}
#Preview {
  ProfileView()
}
