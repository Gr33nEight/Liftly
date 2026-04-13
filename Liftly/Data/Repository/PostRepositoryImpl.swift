//
//  PostRepositoryImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

final class PostRepositoryImpl: PostRepository, @unchecked Sendable {
    private let firestoreClient: FirestoreClient
    
    init(firestoreClient: FirestoreClient) {
        self.firestoreClient = firestoreClient
    }
    
    func createPost(_ entry: PostEntry, transaction: Transaction) throws {
        let dto = PostMapper.toDTO(entry)
        try transaction.setData(dto, for: PostEndpoint.self, id: .init(value: entry.id))
    }
    
    func deletePost(by id: String) async throws {
        try await firestoreClient.delete(for: PostEndpoint.self, id: .init(value: id))
    }
    
    func listenToPost(by id: String) -> AsyncThrowingStream<Post, Error>{
        let stream = firestoreClient.listenDocument(PostEndpoint.self, id: .init(value: id))
        return PostMapper.toStream(stream)
    }
    
    func listenToPosts(by ownersIds: [String]) -> AsyncThrowingStream<[Post], Error> {
        let query = FirestoreQuery().isIn(.field("ownerId"), ownersIds.map({ .string($0) }))
        let stream = firestoreClient.listen(PostEndpoint.self, query: query)
        return PostMapper.toStream(stream)
    }
    
    func updatePost(post: Post) async throws {
        let dto = PostMapper.toDTO(post)
        try await firestoreClient.setData(dto, for: PostEndpoint.self, id: .init(value: post.id), merge: true)
    }
}
