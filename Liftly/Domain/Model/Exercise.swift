//
//  Exercise.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

struct Exercise: Codable, Sendable {
    var title: String
    var image: URL?
    var howTo: String
    var equipment: Equipment
    var primaryMuscleGroup: MuscleGroup
    var otherMuscleGroup: MuscleGroup
    var exerciseType: ExerciseType
}
