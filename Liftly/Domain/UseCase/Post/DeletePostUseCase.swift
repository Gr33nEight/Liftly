//
//  DeletePostUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 13/04/2026.
//

import Foundation

protocol DeletePostUseCase {
    func execute(post: Post) async throws
}

final class DeletePostUseCaseImpl: DeletePostUseCase {
    private let postRepository: PostRepository
    private let trackedExerciseRepository: TrackedExerciseRepository
    
    init(
        postRepository: PostRepository,
        trackedExerciseRepository: TrackedExerciseRepository
    ) {
        self.postRepository = postRepository
        self.trackedExerciseRepository = trackedExerciseRepository
    }
    
    func execute(post: Post) async throws {
        let trackedExercises = try await trackedExerciseRepository.fetchExercises(by: post.workoutId)
        try await postRepository.deletePost(post, trackedExercises: trackedExercises)
    }
}
