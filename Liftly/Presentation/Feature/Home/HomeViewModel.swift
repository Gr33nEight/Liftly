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
    @Published var posts: [PostDetails] = []
    @Published var currentUser: User?
    
    private let currentUserId: String
    private let deletePostUseCase: DeletePostUseCase
    private let fetchPostsUseCase: FetchPostsUseCase
    private let toggleLikeUseCase: ToggleLikeUseCase
    private let getUserUseCase: GetUserUseCase
    
    init(
        currentUserId: String,
        deletePostUseCase: DeletePostUseCase,
        fetchPostsUseCase: FetchPostsUseCase,
        toggleLikeUseCase: ToggleLikeUseCase,
        getUserUseCase: GetUserUseCase
    ) {
        self.currentUserId = currentUserId
        self.deletePostUseCase = deletePostUseCase
        self.fetchPostsUseCase = fetchPostsUseCase
        self.toggleLikeUseCase = toggleLikeUseCase
        self.getUserUseCase = getUserUseCase
    }
    
    func onAppear() async {
        await fetchPosts()
        await fetchCurrentUser()
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
    
    func toggleLike(_ id: String) async {
        guard let idx = posts.firstIndex(where: { $0.id == id }) else { return }

        let toggledPost = posts[idx]
        
        if posts[idx].likedUsers.contains(where: {$0.id == currentUserId}) {
            posts[idx].likedUsers.removeAll(where: {$0.id == currentUserId})
        }else{
            guard let currentUser else { return }
            posts[idx].likedUsers.append(currentUser)
        }
        
        do {
            try await toggleLikeUseCase.execute(post: toggledPost, userId: currentUserId)
        } catch {
            posts[idx] = toggledPost
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func fetchPosts() async {
        do {
            posts = try await fetchPostsUseCase.execute(userId: currentUserId)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func fetchCurrentUser() async {
        do {
            currentUser = try await getUserUseCase.execute(by: currentUserId)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
