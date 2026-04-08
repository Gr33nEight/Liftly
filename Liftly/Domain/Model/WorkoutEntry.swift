//
//  WorkoutEntry.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//


struct WorkoutEntry {
    var id: String
    var duration: Int
    var volume: Double
    var sets: Int
    var exercises: [TrackedExercise]
}
