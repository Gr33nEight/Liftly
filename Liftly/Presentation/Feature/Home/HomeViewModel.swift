//
//  HomeViewModel.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    private let currentUserId: String
    private let deletePostUseCase: DeletePostUseCase
    private let fetchPostsUseCase: FetchPostsUseCase
    private let toggleLikeUseCase: ToggleLikeUseCase
    
    init(
        currentUserId: String,
        deletePostUseCase: DeletePostUseCase,
        fetchPostsUseCase: FetchPostsUseCase,
        toggleLikeUseCase: ToggleLikeUseCase
    ) {
        self.currentUserId = currentUserId
        self.deletePostUseCase = deletePostUseCase
        self.fetchPostsUseCase = fetchPostsUseCase
        self.toggleLikeUseCase = toggleLikeUseCase
    }
    
    func onAppear() async {
        await fetchPosts()
    }
    
    func deletePost(_ post: Post) async {
        guard let idx = posts.firstIndex(where: { $0.id == post.id }) else { return }
        
        let removedPost = posts.remove(at: idx)
        
        do {
            try await deletePostUseCase.execute(post: post)
        } catch {
            posts.insert(removedPost, at: idx)
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func toggleLike(_ post: Post) async {
        guard let idx = posts.firstIndex(where: { $0.id == post.id }) else { return }

        let toggledPost = posts[idx]
        
        if posts[idx].likedUsersIds.contains(currentUserId) {
            posts[idx].likedUsersIds.removeAll(where: {$0 == currentUserId})
        }else{
            posts[idx].likedUsersIds.append(currentUserId)
        }
        
        do {
            try await toggleLikeUseCase.execute(post: post, userId: currentUserId)
        } catch {
            posts[idx] = toggledPost
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func fetchPosts() async {
        do {
            print(currentUserId)
            posts = try await fetchPostsUseCase.execute(userId: currentUserId)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
