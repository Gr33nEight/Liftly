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
        RoutineEntry(id: "", title: "Test", trackedExercises: [], ownerId: "")
    ]
    
    static let stats: [WorkoutData] = [
        WorkoutData(occurence: "Mon", data: 2),
        WorkoutData(occurence: "Tue", data: 1),
        WorkoutData(occurence: "Wed", data: 3),
        WorkoutData(occurence: "Thu", data: 3),
        WorkoutData(occurence: "Fri", data: 2),
        WorkoutData(occurence: "Sat", data: 0),
        WorkoutData(occurence: "Sun", data: 4),
    ]
    
    static let users: [User] = [
        User(id: "1", name: "Natan", email: "test@gmail.com"),
        User(id: "2", name: "Test", email: "test2@gmail.com")
    ]
    
    static let posts: [PostDetails] =
    [
        PostDetails(id: "1", owner: users[0], title: "Test 1", dateCreated: Date(), isPublic: true, likedUsers: [], comments: [], workout: WorkoutEntry(
            id: "", duration: 3820, volume: 12021.5, sets: 22, trackedExercises: [
                TrackedExerciseEntry(id: "1", workoutId: "", exercise: MockData.exercises[0], restTime: 90, sets: MockData.sets),
                TrackedExerciseEntry(id: "2", workoutId: "", exercise: MockData.exercises[1], restTime: 90, sets: MockData.sets)
            ])),
        PostDetails(id: "2", owner: users[1], title: "Test 2", dateCreated: Date(), isPublic: true, likedUsers: [], comments: [], workout: WorkoutEntry(
            id: "", duration: 3820, volume: 12021.5, sets: 22, trackedExercises: [
                TrackedExerciseEntry(id: "1", workoutId: "", exercise: MockData.exercises[0], restTime: 90, sets: MockData.sets),
                TrackedExerciseEntry(id: "2", workoutId: "", exercise: MockData.exercises[1], restTime: 90, sets: MockData.sets)
            ])),
        
    ]
}

struct WorkoutData: Identifiable {
    var id: String = UUID().uuidString
    var occurence: String
    var data: Int
    
}
