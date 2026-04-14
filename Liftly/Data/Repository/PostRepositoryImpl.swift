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
    
    func deletePost(_ post: Post, trackedExercises: [TrackedExercise]) async throws {
        try await firestoreClient.runBatch { batch in
            batch.delete(for: PostEndpoint.self, id: .init(value: post.id))
            batch.delete(for: WorkoutEndpoint.self, id: .init(value: post.workoutId))
            
            for exercise in trackedExercises {
                batch.delete(for: ExerciseEndpoint.self, id: .init(value: exercise.id))
            }
        }
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
    
    func fetchPosts(by ownersIds: [String]) async throws -> [Post] {
        let query = FirestoreQuery().isIn(.field("ownerId"), ownersIds.map({ .string($0) }))
        let dtos = try await firestoreClient.fetch(PostEndpoint.self, query: query)
        return try dtos.map { try PostMapper.toDomain($0) }
    }
    
    func updatePost(post: Post) async throws {
        let dto = PostMapper.toDTO(post)
        try await firestoreClient.setData(dto, for: PostEndpoint.self, id: .init(value: post.id), merge: true)
    }
    
    func addLikeToPost(with postId: String, userId: String) async throws {
        try await firestoreClient.updateData(for: PostEndpoint.self, id: .init(value: postId), ["likedUsersIds" : .union([userId])])
    }
    
    func removeLikeToPost(with postId: String, userId: String) async throws {
        
    }
    
    func updatePostLikes(of postId: String, userId: String) async throws {
        try await firestoreClient.updateData(for: PostEndpoint.self, id: .init(value: postId), ["likedUsersIds" : .remove([userId])])
    }
}
