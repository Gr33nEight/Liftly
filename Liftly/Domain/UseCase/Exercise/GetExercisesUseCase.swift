//
//  GetExercisesUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

protocol GetExercisesUseCase {
    func execute() async -> [Exercise]
}

final class GetExercisesUseCaseImpl: GetExercisesUseCase {
    private let exerciseRepository: ExerciseRepository
    
    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    func execute() async -> [Exercise] {
        await exerciseRepository.getAll()
    }
}


final class MockGetExercisesUseCase: GetExercisesUseCase {
    func execute() async -> [Exercise] {
        return MockData.exercises
    }
}
