//
//  GetRoutineUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

protocol GetRoutineUseCase {
    func execute(routineId: String) async throws -> RoutineEntry
}

final class GetRoutineUseCaseImpl: GetRoutineUseCase {
    private let routineRepository: RoutineRepository
    private let exerciseRepository: ExerciseRepository
    private let trackedExerciseRepository: TrackedExerciseRepository
    
    init(routineRepository: RoutineRepository, exerciseRepository: ExerciseRepository, trackedExerciseRepository: TrackedExerciseRepository) {
        self.routineRepository = routineRepository
        self.exerciseRepository = exerciseRepository
        self.trackedExerciseRepository = trackedExerciseRepository
    }
    
    func execute(routineId: String) async throws -> RoutineEntry {
        let domain = try await routineRepository.fetchRoutine(with: routineId)
        let trackedExercises = try await trackedExerciseRepository.fetchExercises(by: routineId)
        let exercises = await exerciseRepository.getAll()
        let exercisesDict = Dictionary(uniqueKeysWithValues: exercises.map { ($0.id, $0) })
        
        let trackedEntries: [TrackedExerciseEntry] = trackedExercises.compactMap { tracked in
            guard let exercise = exercisesDict[tracked.exerciseId] else { return nil }
        
            let test =  TrackedExerciseEntry(
                id: tracked.id,
                workoutId: routineId,
                exercise: exercise,
                restTime: tracked.restTime,
                sets: tracked.sets
            )
            return test
        }
        
        return RoutineMapper.toEntry(domain, trackedExercises: trackedEntries)
    }
}

final class MockGetRoutineUseCase: GetRoutineUseCase {
    func execute(routineId: String) async -> RoutineEntry {
        return MockData.routines[0]
    }
}
