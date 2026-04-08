
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
    
    @Published var post: PostEntry?
    @Published var duration: Int = 0
    @Published var exercises: [Exercise] = []
    @Published var activeWorkout: Workout?
    @Published var trackedExercises: [TrackedExercise] = []
    
    private let getExercisesUseCase: GetExercisesUseCase
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
        getExercisesUseCase: GetExercisesUseCase,
        createPostUseCase: CreatePostUseCase
    ) {
        self.getExercisesUseCase = getExercisesUseCase
        self.createPostUseCase = createPostUseCase
    }
    
    func onAppear() async {
        await getExercises()
        setupMock()
    }
    
    func createPost() async {
        guard let entry = post else { return }
        
        do {
            try await createPostUseCase.execute(entry: entry)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func getExercises() async {
        self.exercises = await getExercisesUseCase.execute()
    }
}



extension WorkoutViewModel {
    
    private func setupMock() {
        let workoutId = UUID().uuidString
        let postId = UUID().uuidString

        let mockExercises: [TrackedExercise] = [

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

            TrackedExercise(
                id: UUID().uuidString,
                workoutId: workoutId,
                exercise: exercises.randomElement() ?? .empty,
                restTime: "60",
                sets: [
                    ExerciseSet(type: .normal(1), value: .durationWeight(seconds: 40, weight: 20)),
                    ExerciseSet(type: .normal(2), value: .durationWeight(seconds: 50, weight: 25))
                ]
            )
        ]

        self.trackedExercises = mockExercises

        let workoutEntry = WorkoutEntry(
            id: workoutId,
            duration: duration,
            volume: mockExercises.flatMap { $0.sets }.reduce(0) { $0 + $1.value.volume },
            sets: mockExercises.flatMap { $0.sets }.count,
            exercises: mockExercises
        )

        let postEntry = PostEntry(
            id: postId,
            ownerId: "mock-user",
            title: "Leg day 🔥",
            description: "Solid workout today",
            image: nil,
            likedUsersIds: [],
            commentsIds: [],
            workout: workoutEntry
        )

        self.post = postEntry
    }
}
