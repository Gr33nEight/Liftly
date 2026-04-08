//
//  CreateWorkoutUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import Foundation

protocol CreateWorkoutUseCase {
    func execute(workout: Workout, trackedExercises: [TrackedExercise]) async throws
}

final class CreateWorkoutUseCaseImpl: CreateWorkoutUseCase {
    private let workoutRepository: WorkoutRepository
    
    init(workoutRepository: WorkoutRepository) {
        self.workoutRepository = workoutRepository
    }
    
    func execute(workout: Workout, trackedExercises: [TrackedExercise]) async throws {
        let entry = WorkoutEntry(
            id: workout.id,
            duration: workout.duration,
            volume: workout.volume,
            sets: workout.sets,
            exercises: trackedExercises
        )
        try await workoutRepository.createWorkout(entry)
    }
}

