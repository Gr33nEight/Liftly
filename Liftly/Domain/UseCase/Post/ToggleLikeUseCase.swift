//
//  ToggleLikeUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

protocol ToggleLikeUseCase {
    func execute(post: PostEntry, userId: String) async throws
}

final class ToggleLikeUseCaseImpl: ToggleLikeUseCase {
    private let postRepository: PostRepository
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
    
    func execute(post: PostEntry, userId: String) async throws {
        if post.likedUsersIds.contains(userId) {
            try await postRepository.removeLikeToPost(with: post.id, userId: userId)
        }else{
            try await postRepository.addLikeToPost(with: post.id, userId: userId)
        }
    }
}

final class MockToggleLikeUseCase: ToggleLikeUseCase{
    func execute(post: PostEntry, userId: String) async throws {
        return
    }
}
