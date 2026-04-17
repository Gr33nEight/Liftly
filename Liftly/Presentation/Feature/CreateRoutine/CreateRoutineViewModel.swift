//
//  RoutineViewModel.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import Combine
import SwiftUI

@MainActor
final class CreateRoutineViewModel: ObservableObject {
    @Published var trackedExercises: [TrackedExerciseEntry] = []
    @Published var exercises: [Exercise] = []
    
    private var routineId: String = UUID().uuidString
    
    private let currentUserId: String
    private let getExercisesUseCase: GetExercisesUseCase
    private let saveRoutineUseCase: SaveRoutineUseCase
    
    init(
        currentUserId: String,
        getExercisesUseCase: GetExercisesUseCase,
        saveRoutineUseCase: SaveRoutineUseCase
    ) {
        self.currentUserId = currentUserId
        self.getExercisesUseCase = getExercisesUseCase
        self.saveRoutineUseCase = saveRoutineUseCase
    }
    
    func onAppear() async {
        await self.getExercises()
    }
    
    func addTrackedExercises(for exercises: [Exercise]) {
        exercises.forEach { exercise in
            trackedExercises.append(
                TrackedExerciseEntry(
                    id: UUID().uuidString,
                    workoutId: routineId,
                    exercise: exercise,
                    restTime: 90,
                    sets: (1...3).map({ ExerciseSet(type: .normal($0)) })
                )
            )
        }
    }
    
    func removeExercise(_ id: String) {
        trackedExercises.removeAll(where: { $0.id == id })
    }
    
    func removeSetFromExercise(setId: String, exerciseId: String) {
        guard let exerciseIdx = trackedExercises.firstIndex(where: { $0.id == exerciseId }) else { return }
        
        trackedExercises[exerciseIdx].sets.removeAll { $0.id == setId }
        var normalIndex = 1
        
        for idx in trackedExercises[exerciseIdx].sets.indices {
            switch trackedExercises[exerciseIdx].sets[idx].type {
            case .normal:
                trackedExercises[exerciseIdx].sets[idx].type = .normal(normalIndex)
                normalIndex += 1
            default:
                continue
            }
        }
    }
    
    func saveRoutine(title: String) async {
        let createdRoutine = CreateRoutineInput(
            title: title,
            trackedExercises: trackedExercises,
            ownerId: currentUserId
        )
        
        do {
            guard !title.isEmpty else { throw RoutineError.titleIsEmpty }
            try await saveRoutineUseCase.execute(createdRoutine, routineId: routineId)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func getExercises() async {
        self.exercises = await getExercisesUseCase.execute()
    }
}

enum RoutineError: Error {
    case titleIsEmpty
}
