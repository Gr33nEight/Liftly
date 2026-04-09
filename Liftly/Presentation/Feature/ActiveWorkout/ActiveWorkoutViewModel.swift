//
//  ActiveWorkoutViewModel.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI
import Combine

@MainActor
final class ActiveWorkoutViewModel: ObservableObject {
    @Published var post: PostEntry?
    @Published var duration: Int = 0
    @Published var activeWorkout: Workout?
    @Published var trackedExercises: [TrackedExercise] = []
    
    private let exercises: [Exercise]
    private let createPostUseCase: CreatePostUseCase
    
    var totalSets: Int {
        trackedExercises.flatMap { $0.sets }.count
    }
    
    var totalVolume: Double {
        trackedExercises
            .flatMap { $0.sets }
            .reduce(0) { $0 + $1.value.volume }
    }
    
    init(
        routineId: String,
        createPostUseCase: CreatePostUseCase
    ) {
        self.exercises = MockData.exercises
        self.createPostUseCase = createPostUseCase
    }
    
    func createPost() async {
        guard let entry = post else { return }
        
        do {
            try await createPostUseCase.execute(entry: entry)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func addTrackedExercise(for exercise: Exercise) {
        trackedExercises.append(
            TrackedExercise(
                id: UUID().uuidString,
                workoutId: "",
                exercise: exercise,
                restTime: "",
                sets: []
            )
        )
    }
}
