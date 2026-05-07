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
    private var startDate: Date?
    var duration: Int {
        guard let startDate else { return 0 }
        return Int(Date().timeIntervalSince(startDate))
    }
    
    @Published var trackedExercises: [TrackedExerciseEntry] = []
    @Published var exercises: [Exercise] = []
    @Published var title: String = ""
    
    @Published var restTime: Int = 0
    @Published var totalRestTime: Int = 0
    @Published var isRestRunning: Bool = false

    private var timer: Timer?
    
    private var activeWorkoutId: String = UUID().uuidString
    
    private let currentUserId: String
    private let routineId: String?
    private let createPostUseCase: CreatePostUseCase
    private let getExercisesUseCase: GetExercisesUseCase
    private let getRoutineUseCase: GetRoutineUseCase
    
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
        getExercisesUseCase: GetExercisesUseCase,
        getRoutineUseCase: GetRoutineUseCase
    ) {
        self.currentUserId = currentUserId
        self.routineId = routineId
        self.exercises = MockData.exercises
        self.createPostUseCase = createPostUseCase
        self.getExercisesUseCase = getExercisesUseCase
        self.getRoutineUseCase = getRoutineUseCase
    }
    
    func startWorkout() async {
        startDate = Date()
        await getExercises()
        
        if let routineId {
            await self.startRoutine(routineId: routineId)
        }
    }
    
    @MainActor
    func startRoutine(routineId: String) async {
        do {
            let routine = try await getRoutineUseCase.execute(routineId: routineId)
            addTrackedFromRoutine(routine)
            title = routine.title
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func buildPost(description: String?, date: Date, isPublic: Bool, image: Data?) -> CreatePostInput {
        let workoutEntry = WorkoutEntry(
            id: activeWorkoutId,
            duration: duration,
            volume: totalVolume,
            sets: totalSets,
            trackedExercises: trackedExercises
        )
        
        return CreatePostInput(
            ownerId: currentUserId,
            title: title,
            dateCreated: date,
            description: description,
            image: image,
            isPublic: isPublic,
            workout: workoutEntry
        )
    }
    
    func savePost(description: String?, date: Date, isPublic: Bool, image: Data?) async {
        let input = self.buildPost(description: description, date: date, isPublic: isPublic, image: image)
        
        do {
            try await createPostUseCase.execute(input: input)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func addTrackedExercises(for exercises: [Exercise]) {
        exercises.forEach { exercise in
            trackedExercises.append(
                TrackedExerciseEntry(
                    id: UUID().uuidString,
                    workoutId: activeWorkoutId,
                    exercise: exercise,
                    restTime: 90,
                    sets: (1...3).map({ ExerciseSet(type: .normal($0)) })
                )
            )
        }
    }
    
    private func addTrackedFromRoutine(_ routine: RoutineEntry) {
        trackedExercises += routine.trackedExercises.map {
            var updated = $0
            updated.workoutId = activeWorkoutId
            updated.id = UUID().uuidString
            return updated
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
