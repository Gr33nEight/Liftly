//
//  TrackedExerciseEntry.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

struct TrackedExerciseEntry: Identifiable {
    var id: String
    var workoutId: String
    var exercise: Exercise
    var restTime: Int
    var sets: [ExerciseSet]
}

extension TrackedExerciseEntry {
    var hasWeight: Bool { exercise.exerciseType.usesWeight }
    var hasReps: Bool { exercise.exerciseType.usesReps }
    var hasDistance: Bool { exercise.exerciseType.usesDistance }
    var hasDuration: Bool { exercise.exerciseType.usesDuration }
}
