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
    
    @Published var trackedExercises: [TrackedExercise] = []
    @Published var exercises: [Exercise] = []
    
    @Published var restTime: Int = 0
    @Published var totalRestTime: Int = 0
    @Published var isRestRunning: Bool = false

    private var timer: Timer?
    
    private var activeWorkoutId: String = UUID().uuidString
    
    private let currentUserId: String
    private let createPostUseCase: CreatePostUseCase
    private let getExercisesUseCase: GetExercisesUseCase
    
    var totalSets: Int {
        trackedExercises
            .flatMap { $0.sets }
            .filter({ $0.isDone })
            .count
    }
    
    var totalVolume: Double {
        trackedExercises
            .flatMap { $0.sets }
            .filter({ $0.isDone })
            .reduce(0) { $0 + $1.volume }
    }
    
    init(
        currentUserId: String,
        routineId: String?,
        createPostUseCase: CreatePostUseCase,
        getExercisesUseCase: GetExercisesUseCase
    ) {
        self.currentUserId = currentUserId
        self.exercises = MockData.exercises
        self.createPostUseCase = createPostUseCase
        self.getExercisesUseCase = getExercisesUseCase
    }
    
    func startWorkout() async {
        startDate = Date()
        await getExercises()
    }
    
    func buildPost(title: String, description: String?, date: Date, isPublic: Bool) -> PostEntry {
        let workoutEntry = WorkoutEntry(
            id: activeWorkoutId,
            duration: duration,
            volume: totalVolume,
            sets: totalSets,
            exercises: trackedExercises
        )
        
        return PostEntry(
            id: UUID().uuidString,
            ownerId: currentUserId,
            title: title,
            dateCreated: date,
            description: description,
            image: nil,
            isPublic: isPublic,
            likedUsersIds: [],
            commentsIds: [],
            workout: workoutEntry
        )
    }
    
    func savePost(title: String, description: String?, date: Date, isPublic: Bool) async {
        let entry = self.buildPost(title: title, description: description, date: date, isPublic: isPublic)
        
        do {
            try await createPostUseCase.execute(entry: entry)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func addTrackedExercises(for exercises: [Exercise]) {
        exercises.forEach { exercise in
            trackedExercises.append(
                TrackedExercise(
                    id: UUID().uuidString,
                    workoutId: activeWorkoutId,
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
    
    func startRestTimer(time: Int) {
        restTime = time
        totalRestTime = time
        withAnimation(.easeInOut) {
            isRestRunning = true
        }
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { @MainActor in
                guard let self else { return }
                
                if self.restTime > 0 {
                    self.restTime -= 1
                } else {
                    self.stopRestTimer()
                }
            }
        }
    }
    
    func stopRestTimer() {
        timer?.invalidate()
        timer = nil
        withAnimation(.easeInOut) {
            isRestRunning = false
        }
    }
    
    func addRestTime(_ value: Int) {
        restTime += value
    }

    func subtractRestTime(_ value: Int) {
        restTime = max(0, restTime - value)
    }
    
    private func getExercises() async {
        self.exercises = await getExercisesUseCase.execute()
    }
}
