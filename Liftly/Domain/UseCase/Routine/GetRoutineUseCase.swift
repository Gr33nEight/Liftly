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
    
    init(routineRepository: RoutineRepository, exerciseRepository: ExerciseRepository) {
        self.routineRepository = routineRepository
        self.exerciseRepository = exerciseRepository
    }
    
    func execute(routineId: String) async throws -> RoutineEntry {
        let allExercises = await exerciseRepository.getAll()
        let domain = try await routineRepository.fetchRoutine(with: routineId)
        let exercises = allExercises.filter({ domain.exercisesIds.contains($0.id) })
        
        return RoutineMapper.toEntry(domain, exercises: exercises)
    }
}

final class MockGetRoutineUseCase: GetRoutineUseCase {
    func execute(routineId: String) async -> RoutineEntry {
        return MockData.routines[0]
    }
}
