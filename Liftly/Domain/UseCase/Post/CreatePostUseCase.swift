//
//  CreatePostUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import Foundation

protocol CreatePostUseCase {
    func execute(entry: PostEntry) async throws
}

final class CreatePostUseCaseImpl: CreatePostUseCase {

    private let transactionProvider: TransactionProvider
    private let trackedExerciseRepo: TrackedExerciseRepository
    private let workoutRepo: WorkoutRepository
    private let postRepo: PostRepository

    init(
        transactionProvider: TransactionProvider,
        trackedExerciseRepo: TrackedExerciseRepository,
        workoutRepo: WorkoutRepository,
        postRepo: PostRepository
    ) {
        self.transactionProvider = transactionProvider
        self.trackedExerciseRepo = trackedExerciseRepo
        self.workoutRepo = workoutRepo
        self.postRepo = postRepo
    }

    func execute(entry: PostEntry) async throws {
        try await transactionProvider.runTransaction { [trackedExerciseRepo, workoutRepo, postRepo] transaction in

            try trackedExerciseRepo.createExercises(entry.workout.exercises, transaction: transaction)
            try workoutRepo.createWorkout(entry.workout, transaction: transaction)
            try postRepo.createPost(entry, transaction: transaction)
        }
    }
}

final class MockCreatePostUseCase: CreatePostUseCase {
    func execute(entry: PostEntry) async throws {
        return
    }
}
