//
//  CreatePostUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import Foundation

protocol CreatePostUseCase {
    func execute(entry: PostEntry, image: Data?) async throws
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
    
    func execute(entry: PostEntry, image: Data?) async throws {
        var updatedEntry = entry
        var uploadedPath: StoragePath?
        
        do {
            // 🔥 STEP 1: upload image
            if let imageData = image {
                let path = StoragePath.postImage(postId: entry.id)
                
                let url = try await storageRepo.uploadImage(
                    data: imageData,
                    path: path
                )
                
                updatedEntry.image = url
                uploadedPath = path
            }
            
            try await transactionProvider.runTransaction {
                [trackedExerciseRepo, workoutRepo, postRepo, updatedEntry] transaction in
                
                try trackedExerciseRepo.createExercises(
                    updatedEntry.workout.trackedExercises,
                    transaction: transaction
                )
                
                try workoutRepo.createWorkout(
                    updatedEntry.workout,
                    transaction: transaction
                )
                
                try postRepo.createPost(
                    updatedEntry,
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
    func execute(entry: PostEntry, image: Data?) async throws {
        return
    }
}
