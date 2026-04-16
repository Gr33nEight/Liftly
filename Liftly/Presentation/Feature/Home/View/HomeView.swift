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
        ScrollView {
            LazyVStack {
                if viewModel.posts.isEmpty {
                    Text("Gówno")
                }else{
                    ForEach(viewModel.posts, id: \.id) { post in
                        Text(post.title)
                    }
                }
            }.foregroundStyle(.accent)
        }.task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
//    HomeView(viewModel: HomeViewModel())
}
