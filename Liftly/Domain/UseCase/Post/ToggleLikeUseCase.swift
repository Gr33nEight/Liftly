//
//  ToggleLikeUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

protocol ToggleLikeUseCase {
    func execute(post: PostDetails, userId: String) async throws
}

final class ToggleLikeUseCaseImpl: ToggleLikeUseCase {
    private let postRepository: PostRepository
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
    
    func execute(post: PostDetails, userId: String) async throws {
        if post.likedUsers.contains(where: { $0.id == userId }) {
            try await postRepository.removeLikeToPost(with: post.id, userId: userId)
        }else{
            try await postRepository.addLikeToPost(with: post.id, userId: userId)
        }
    }
}
