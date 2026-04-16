//
//  CreatePostUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import Foundation

protocol CreatePostUseCase {
    func execute(input: CreatePostInput) async throws
}

final class CreatePostUseCaseImpl: CreatePostUseCase {
    
    private let transactionProvider: TransactionProvider
    private let trackedExerciseRepo: TrackedExerciseRepository
    private let workoutRepo: WorkoutRepository
    private let postRepo: PostRepository
    private let storageRepo: StorageRepository
    
    init(
        transactionProvider: TransactionProvider,
        trackedExerciseRepo: TrackedExerciseRepository,
        workoutRepo: WorkoutRepository,
        postRepo: PostRepository,
        storageRepo: StorageRepository
    ) {
        self.transactionProvider = transactionProvider
        self.trackedExerciseRepo = trackedExerciseRepo
        self.workoutRepo = workoutRepo
        self.postRepo = postRepo
        self.storageRepo = storageRepo
    }
    
    func execute(input: CreatePostInput) async throws {
        let postId = UUID().uuidString
        var imageURL: URL?
        var uploadedPath: StoragePath?
        
        do {
            if let imageData = input.image {
                let path = StoragePath.postImage(postId: postId)
                let url = try await storageRepo.uploadImage(data: imageData, path: path)
                
                imageURL = url
                uploadedPath = path
            }
            
            let workout = input.workout
            let post = PostMapper.toDomain(input, postId: postId, imageUrl: imageURL, workoutId: workout.id)
            
            try await transactionProvider.runTransaction {
                [trackedExerciseRepo, workoutRepo, postRepo] transaction in
                
                try trackedExerciseRepo.createExercises(
                    workout.trackedExercises,
                    transaction: transaction
                )
                
                try workoutRepo.createWorkout(
                    workout,
                    transaction: transaction
                )
                
                try postRepo.createPost(
                    post,
                    transaction: transaction
                )
            }
            
        } catch {
            if let path = uploadedPath {
                try? await storageRepo.deleteImage(path: path)
            }
            
            throw error
        }
    }
}

final class MockCreatePostUseCase: CreatePostUseCase {
    func execute(input: CreatePostInput) async throws {
        return
    }
}
