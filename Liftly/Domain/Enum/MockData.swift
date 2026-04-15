//
//  MockData.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//
import SwiftUI

enum MockData {
    static let exercises: [Exercise] = [
        Exercise(
            id: "bench_press_barbell",
            title: "Bench Press (Barbell)",
            imageUrl: URL(string: "https://d2l9nsnmtah87f.cloudfront.net/exercise-thumbnails/00251201-Barbell-Bench-Press_Chest_thumbnail@3x.jpg"),
            videoUrl: URL(string: "https://d2l9nsnmtah87f.cloudfront.net/exercise-assets/00251201-Barbell-Bench-Press_Chest.mp4"),
            howTo: "Lie on the bench. Extend your arms and grab the bar evenly, having your hands slightly wider than shoulder-width apart. Bring your shoulder blades back and dig them into the bench. Arch your lower back and plant your feet flat on the floor. Take a breath, unrack the bar, and bring it over your chest. Inhale again and lower the barbell to your lower chest, tapping it slightly. Hold for a moment and press the bar until your elbows are straight. Exhale.",
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
