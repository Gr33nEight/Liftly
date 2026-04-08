
//
//  WorkoutViewModel.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import SwiftUI
import Combine

@MainActor
final class WorkoutViewModel: ObservableObject {
    
    @Published var duration: Int = 0
    @Published var exercises: [Exercise] = []
    @Published var activeWorkout: Workout?
    @Published var trackedExercises: [TrackedExercise] = []
    
    private let getExercisesUseCase: GetExercisesUseCase
    private let createWorkoutUseCase: CreateWorkoutUseCase
    
    var totalSets: Int {
        trackedExercises.flatMap { $0.sets }.count
    }
    
    var totalVolume: Double {
        trackedExercises
            .flatMap { $0.sets }
            .reduce(0) { $0 + $1.value.volume }
    }
    
    init(
        getExercisesUseCase: GetExercisesUseCase,
        createWorkoutUseCase: CreateWorkoutUseCase
    ) {
        self.getExercisesUseCase = getExercisesUseCase
        self.createWorkoutUseCase = createWorkoutUseCase
    }
    
    func onAppear() async {
        await getExercises()
        setupMock()
    }
    
    func createWorkout() async {
        guard let workout = activeWorkout else { return }
        
        do {
            try await createWorkoutUseCase.execute(
                workout: workout,
                trackedExercises: trackedExercises
            )
        } catch {
            print("Error:", error)
        }
    }
    
    private func getExercises() async {
        self.exercises = await getExercisesUseCase.execute()
    }
}



extension WorkoutViewModel {
    private func setupMock() {
        let workoutId = UUID().uuidString

        let mockExercises: [TrackedExercise] = [

            // 🏋️ weight & reps
            TrackedExercise(
                id: UUID().uuidString,
                workoutId: workoutId,
                exercise: exercises.randomElement() ?? .empty,
                restTime: "90",
                sets: [
                    ExerciseSet(type: .normal(1), value: .weightReps(weight: 60, reps: 12)),
                    ExerciseSet(type: .normal(2), value: .weightReps(weight: 80, reps: 10)),
                    ExerciseSet(type: .normal(3), value: .weightReps(weight: 100, reps: 6))
                ]
            ),

            // 💪 bodyweight
            TrackedExercise(
                id: UUID().uuidString,
                workoutId: workoutId,
                exercise: exercises.randomElement() ?? .empty,
                restTime: "60",
                sets: [
                    ExerciseSet(type: .normal(1), value: .bodyweightReps(reps: 15)),
                    ExerciseSet(type: .normal(2), value: .bodyweightReps(reps: 12)),
                    ExerciseSet(type: .failure, value: .bodyweightReps(reps: 10))
                ]
            ),

            // ⏱ duration
            TrackedExercise(
                id: UUID().uuidString,
                workoutId: workoutId,
                exercise: exercises.randomElement() ?? .empty,
                restTime: "45",
                sets: [
                    ExerciseSet(type: .normal(1), value: .duration(seconds: 30)),
                    ExerciseSet(type: .normal(2), value: .duration(seconds: 45)),
                    ExerciseSet(type: .normal(3), value: .duration(seconds: 60))
                ]
            ),

            // 🏃 distance + duration (Twój przykład, ale lepiej)
            TrackedExercise(
                id: UUID().uuidString,
                workoutId: workoutId,
                exercise: exercises.randomElement() ?? .empty,
                restTime: "30",
                sets: [
                    ExerciseSet(type: .normal(1), value: .distanceDuration(distance: 200, seconds: 60)),
                    ExerciseSet(type: .normal(2), value: .distanceDuration(distance: 300, seconds: 80))
                ]
            ),

            // 🏋️ duration + weight
            TrackedExercise(
                id: UUID().uuidString,
                workoutId: workoutId,
                exercise: exercises.randomElement() ?? .empty,
                restTime: "60",
                sets: [
                    ExerciseSet(type: .normal(1), value: .durationWeight(seconds: 40, weight: 20)),
                    ExerciseSet(type: .normal(2), value: .durationWeight(seconds: 50, weight: 25))
                ]
            ),

            // 🧪 edge case (ważne do testów UI)
            TrackedExercise(
                id: UUID().uuidString,
                workoutId: workoutId,
                exercise: exercises.randomElement() ?? .empty,
                restTime: "10",
                sets: [
                    ExerciseSet(type: .warmUp, value: .weightReps(weight: 20, reps: 15)),
                    ExerciseSet(type: .drop, value: .weightReps(weight: 40, reps: 20))
                ]
            )
        ]

        self.trackedExercises = mockExercises

        let workout = Workout(
            id: workoutId,
            duration: duration,
            volume: totalVolume,
            sets: totalSets,
            exercisesIds: mockExercises.map { $0.id }
        )

        self.activeWorkout = workout
    }
}
