//
//  SaveRoutineUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 17/04/2026.
//

protocol SaveRoutineUseCase {
    func execute(_ input: CreateRoutineInput, routineId: String) async throws
}

final class SaveRoutineUseCaseImpl: SaveRoutineUseCase {
    private let transactionProvider: TransactionProvider
    private let routineRepository: RoutineRepository
    private let trackedExercisesRepository: TrackedExerciseRepository
    
    init(transactionProvider: TransactionProvider, routineRepository: RoutineRepository, trackedExercisesRepository: TrackedExerciseRepository) {
        self.transactionProvider = transactionProvider
        self.routineRepository = routineRepository
        self.trackedExercisesRepository = trackedExercisesRepository
    }
    
    func execute(_ input: CreateRoutineInput, routineId: String) async throws {
        let routine = RoutineMapper.toDomain(input, routineId: routineId)
        try await transactionProvider.runTransaction { [trackedExercisesRepository, routineRepository] transaction in
            try trackedExercisesRepository.createExercises(input.trackedExercises, transaction: transaction)
            try routineRepository.createRoutine(routine, transaction: transaction)
        }
    }
}

final class MockSaveRoutineUseCase: SaveRoutineUseCase {
    func execute(_ input: CreateRoutineInput, routineId: String) async throws {
        return
    }
}
