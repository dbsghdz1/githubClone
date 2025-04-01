//
//  ProfileView.swift
//  githubClone
//
//  Created by Yunhong on 3/22/25.
//

import SwiftUI

struct ProfileView: View {
  @State private var user: User?
  private let profileList = ["리포지토리", "별표 표시", "조직", "프로젝트"]
  private let colorList = [
    Color.gitRepoColor,
    Color.gitStartColor,
    Color.gitOrgColor,
    Color.gitProjectColor
  ]
  private let profileIconList = ["book.closed", "star", "building.2", "list.bullet.rectangle"]
  private var gridItems: [GridItem] = [
    GridItem(.flexible())
  ]
  var body: some View {
    ScrollView {
      VStack {
        HStack {
          Spacer()
          Image(systemName: "gearshape")
            .imageScale(.large)
            .foregroundStyle(.blue)
            .font(.headline)
            .onTapGesture {
              print("tapped")
            }
            .padding(.trailing, 16)
          Image(systemName: "square.and.arrow.up")
            .imageScale(.large)
            .foregroundStyle(.blue)
            .font(.headline)
            .onTapGesture {
              print("tapped")
            }
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
          print("버튼눌림")
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
        .padding(.horizontal, 16)
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
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
        VStack(spacing: 0) {
          ForEach(profileList, id: \.self) { list in
            let index = profileList.firstIndex(of: list)
            HStack {
              Image(systemName: profileIconList[index ?? 0])
                .frame(width: 20, height: 20)
                .padding(.all, 8)
                .background(colorList[index ?? 0])
                .clipShape(RoundedRectangle(cornerRadius: 5))
              Text(list)
                .padding(.leading, 8)
              Spacer()
            }
            .padding(.all)
            if index != profileList.count - 1 {
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
