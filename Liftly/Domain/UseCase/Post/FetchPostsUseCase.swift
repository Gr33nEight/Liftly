//
//  FetchPostsUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 13/04/2026.
//

import Foundation

protocol FetchPostsUseCase {
    func execute(userId: String) async throws -> [Post]
}

final class FetchPostsUseCaseImpl: FetchPostsUseCase {
    private let postRepository: PostRepository
    private let userRepository: UserRepository
    
    init(postRepository: PostRepository, userRepository: UserRepository) {
        self.postRepository = postRepository
        self.userRepository = userRepository
    }
    
    func execute(userId: String) async throws -> [Post] {
        let user = try await userRepository.fetchUser(by: userId)
        let allIds = user.followingIds + [userId]
        return try await postRepository.fetchPosts(by: allIds)
    }
}
