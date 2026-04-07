//
//  Workout.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

struct Workout: Identifiable {
    var id: String
    var workoutId: String
    var duration: Int
    var volume: Int
    var sets: Int
    var exercisesIds: [String]
}
