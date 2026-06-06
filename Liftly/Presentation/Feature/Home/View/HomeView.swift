//
//  HomeView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Text("Home")
                    .font(.custom.largeTitle())
                Spacer()
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                }
            
                Button(action: {}) {
                    Image(systemName: "bell")
                }
            }.padding(.horizontal)
                .padding(.bottom, 10)
                .background(Color.custom.darkerBackground)
            
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 20) {
                    ForEach (viewModel.posts, id: \.title){ post in
                        PostCell(post: post)
                            .padding(.vertical)
                            .background(Color.custom.background)
                    }
                }.background(Color.custom.darkerBackground)
                .padding(.top, 10)
            }
        }.background(Color.custom.background)
            .task {
                await viewModel.onAppear()
            }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(currentUserId: "", deletePostUseCase: MockDeletePostUseCase(), fetchPostsUseCase: MockFetchPostsUseCase(), toggleLikeUseCase: MockToggleLikeUseCase(), getUserUseCase: MockGetUserUseCase()))
        .preferredColorScheme(.dark)
}
