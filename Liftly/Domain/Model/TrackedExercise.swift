//
//  TrackedExercise.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

struct TrackedExercise: Identifiable {
    var id: String
    var workoutId: String
    var exercise: Exercise
    var restTime: String
    var sets: [ExerciseSet]
}
