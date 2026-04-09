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
    
    private var startDate: Date?
    var duration: Int {
        guard let startDate else { return 0 }
        return Int(Date().timeIntervalSince(startDate))
    }
    
    @Published var activeWorkout: Workout?
    @Published var trackedExercises: [TrackedExercise] = [
        .init(
            id: UUID().uuidString,
            workoutId: UUID().uuidString,
            exercise: MockData.exercises[0],
            restTime: 90,
            sets: [
                ExerciseSet(
                    type: .normal(1),
                    weight: 12.5,
                    reps: 10
                ),
                ExerciseSet(
                    type: .normal(2),
                    weight: 12.5,
                    reps: 8
                ),
                ExerciseSet(
                    type: .normal(3),
                    weight: 10,
                    reps: 12
                )
            ]
        )
    ]
    @Published var exercises: [Exercise] = []
        
    private let createPostUseCase: CreatePostUseCase
    private let getExercisesUseCase: GetExercisesUseCase
    
    var totalSets: Int {
        trackedExercises.flatMap { $0.sets }.count
    }
    
    var totalVolume: Double {
        trackedExercises
            .flatMap { $0.sets }
            .reduce(0) { $0 + $1.volume }
    }
    
    init(
        routineId: String?,
        createPostUseCase: CreatePostUseCase,
        getExercisesUseCase: GetExercisesUseCase
    ) {
        self.exercises = MockData.exercises
        self.createPostUseCase = createPostUseCase
        self.getExercisesUseCase = getExercisesUseCase
    }
    
    func startWorkout() async {
        startDate = Date()
        await getExercises()
    }
    
    func createPost() async {
        guard let entry = post else { return }
        
        do {
            try await createPostUseCase.execute(entry: entry)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func addTrackedExercises(for exercises: [Exercise]) {
//        exercises.forEach { exercise in
//            trackedExercises.append(
//                TrackedExercise(
//                    id: UUID().uuidString,
//                    workoutId: "",
//                    exercise: exercise,
//                    restTime: 90,
//                    sets: []
//                )
//            )
//        }
    }
    
    private func getExercises() async {
        self.exercises = await getExercisesUseCase.execute()
    }
}
