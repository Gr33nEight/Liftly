//
//  PostRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

protocol PostRepository: Sendable {
    func createPost(_ entry: PostEntry, transaction: Transaction) throws
    func deletePost(_ post: Post, trackedExercises: [TrackedExercise]) async throws
    func listenToPost(by id: String) -> AsyncThrowingStream<Post, Error>
    func listenToPosts(by ownersIds: [String]) -> AsyncThrowingStream<[Post], Error>
    func fetchPosts(by ownersIds: [String]) async throws -> [Post]
    func updatePost(post: Post) async throws
    func addLikeToPost(with postId: String, userId: String) async throws
    func removeLikeToPost(with postId: String, userId: String) async throws
}
