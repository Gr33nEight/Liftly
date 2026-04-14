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
    private let exerciseRepository: ExerciseRepository
    
    init(routineRepository: RoutineRepository, exerciseRepository: ExerciseRepository) {
        self.routineRepository = routineRepository
        self.exerciseRepository = exerciseRepository
    }
    
    func execute(uid: String) async throws -> [RoutineEntry] {
        var results = [RoutineEntry]()
        let routines = try await routineRepository.fetchRoutines(for: uid)
        let allExercises = await exerciseRepository.getAll()
        
        for routine in routines {
            let exercises = allExercises.filter({ routine.exercisesIds.contains($0.id) })
            let entry = RoutineMapper.toEntry(routine, exercises: exercises)
            results.append(entry)
        }
        
        return results
    }
}

final class MockGetRoutinesUseCase: GetRoutinesUseCase {
    func execute(uid: String) async -> [RoutineEntry] {
        return MockData.routines
    }
}

