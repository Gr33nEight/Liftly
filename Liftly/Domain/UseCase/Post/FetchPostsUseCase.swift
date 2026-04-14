//
//  FetchPostsUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 13/04/2026.
//

import Foundation

protocol FetchPostsUseCase {
    func execute(userId: String) async throws -> [PostEntry]
}

final class FetchPostsUseCaseImpl: FetchPostsUseCase {
    private let postRepository: PostRepository
    private let userRepository: UserRepository
    private let workoutRepository: WorkoutRepository
    private let trackedExerciseRepository: TrackedExerciseRepository
    private let exerciseRepository: ExerciseRepository
    
    init(
        postRepository: PostRepository,
        userRepository: UserRepository,
        workoutRepository: WorkoutRepository,
        trackedExerciseRepository: TrackedExerciseRepository,
        exerciseRepository: ExerciseRepository
    ) {
        self.postRepository = postRepository
        self.userRepository = userRepository
        self.workoutRepository = workoutRepository
        self.trackedExerciseRepository = trackedExerciseRepository
        self.exerciseRepository = exerciseRepository
    }
    
    func execute(userId: String) async throws -> [PostEntry] {
        let user = try await userRepository.fetchUser(by: userId)
        let allIds = user.followingIds + [userId]
        let posts = try await postRepository.fetchPosts(by: allIds)
        
        let exercises = await exerciseRepository.getAll()
        let exercisesDict = Dictionary(uniqueKeysWithValues: exercises.map { ($0.id, $0) })
        
        return try await withThrowingTaskGroup(of: PostEntry.self) { group in
            
            for post in posts {
                group.addTask { [workoutRepository, trackedExerciseRepository] in
                    let workout = try await workoutRepository.fetchWorkout(by: post.workoutId)
                    let trackedExercises = try await trackedExerciseRepository.fetchExercises(by: workout.id)
                    
                    let trackedEntries: [TrackedExerciseEntry] = trackedExercises.compactMap { tracked in
                        guard let exercise = exercisesDict[tracked.exerciseId] else { return nil }
                        
                        return TrackedExerciseEntry(
                            id: tracked.id,
                            workoutId: workout.id,
                            exercise: exercise,
                            restTime: tracked.restTime,
                            sets: tracked.sets
                        )
                    }
                    
                    let workoutEntry = WorkoutEntry(
                        id: workout.id,
                        duration: workout.duration,
                        volume: workout.volume,
                        sets: workout.sets,
                        trackedExercises: trackedEntries
                    )
                    
                    return PostEntry(
                        id: post.id,
                        ownerId: post.ownerId,
                        title: post.title,
                        dateCreated: post.dateCreated,
                        image: post.image,
                        isPublic: post.isPublic,
                        likedUsersIds: post.likedUsersIds,
                        commentsIds: post.commentsIds,
                        workout: workoutEntry
                    )
                }
            }
        
            var result: [PostEntry] = []
            for try await entry in group {
                result.append(entry)
            }
            
            return result
        }
    }
}
