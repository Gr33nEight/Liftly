//
//  PostRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

protocol PostRepository: Sendable {
    func createPost(_ entry: PostEntry, transaction: Transaction) throws
    func deletePost(by id: String) async throws
    func listenToPost(by id: String) -> AsyncThrowingStream<Post, Error>
    func listenToPosts(by ownersIds: [String]) -> AsyncThrowingStream<[Post], Error>
    func updatePost(post: Post) async throws
}
