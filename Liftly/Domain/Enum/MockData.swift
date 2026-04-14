//
//  MockData.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//


enum MockData {
    static let exercises: [Exercise] = [
        Exercise(
            id: "bench_press",
            title: "Bench Press",
            howTo: "Press the bar",
            equipment: .barbell,
            primaryMuscleGroup: .chest,
            otherMuscleGroup: .triceps,
            exerciseType: .weightReps
        ),
        Exercise(
            id: "pull_ups",
            title: "Pull Ups",
            howTo: "Pull yourself",
            equipment: .none,
            primaryMuscleGroup: .lats,
            otherMuscleGroup: .biceps,
            exerciseType: .bodyweightReps
        )
    ]
    
    static let sets: [ExerciseSet] = [
        ExerciseSet(
            type: .normal(1),
            isDone: true,
            weight: 12.5,
            reps: 10,
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
    
    static let routines: [RoutineEntry] = [
        RoutineEntry(id: "", title: "Test", exercises: MockData.exercises, ownerId: ""),
        RoutineEntry(id: "", title: "Test2", exercises: MockData.exercises, ownerId: ""),
        RoutineEntry(id: "", title: "Test3", exercises: MockData.exercises, ownerId: ""),
    ]
}
