//
//  GetRoutinesUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

protocol GetRoutinesUseCase {
    func execute(uid: String) async throws -> [RoutineEntry]
}

final class GetRoutinesUseCaseImpl: GetRoutinesUseCase {
    private let routineRepository: RoutineRepository
    private let trackedExerciseRepository: TrackedExerciseRepository
    private let exerciseRepository: ExerciseRepository
    
    init(routineRepository: RoutineRepository, trackedExerciseRepository: TrackedExerciseRepository, exerciseRepository: ExerciseRepository) {
        self.routineRepository = routineRepository
        self.trackedExerciseRepository = trackedExerciseRepository
        self.exerciseRepository = exerciseRepository
    }
    
    func execute(uid: String) async throws -> [RoutineEntry] {
        let routines = try await routineRepository.fetchRoutines(for: uid)
        let exercises = await exerciseRepository.getAll()
        let exercisesDict = Dictionary(uniqueKeysWithValues: exercises.map { ($0.id, $0) })
        
        return try await withThrowingTaskGroup(of: RoutineEntry.self) { group in
            for routine in routines {
                group.addTask { [trackedExerciseRepository] in
                    let trackedExercises = try await trackedExerciseRepository.fetchExercises(by: routine.id)
                    
                    let trackedEntries: [TrackedExerciseEntry] = trackedExercises.compactMap { tracked in
                        guard let exercise = exercisesDict[tracked.exerciseId] else { return nil }
                        
                        return TrackedExerciseEntry(
                            id: tracked.id,
                            workoutId: routine.id,
                            exercise: exercise,
                            restTime: tracked.restTime,
                            sets: tracked.sets
                        )
                    }
                    
                    return RoutineMapper.toEntry(routine, trackedExercises: trackedEntries)
                }
            }
            var result: [RoutineEntry] = []
            for try await entry in group {
                result.append(entry)
            }
            
            return result
        }
    }
}

final class MockGetRoutinesUseCase: GetRoutinesUseCase {
    func execute(uid: String) async -> [RoutineEntry] {
        return MockData.routines
    }
}

