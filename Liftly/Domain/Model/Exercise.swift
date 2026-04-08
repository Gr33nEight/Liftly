//
//  Exercise.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

struct Exercise: Codable, Sendable, Hashable {
    var title: String
    var image: URL?
    var howTo: String
    var equipment: Equipment
    var primaryMuscleGroup: MuscleGroup
    var otherMuscleGroup: MuscleGroup
    var exerciseType: ExerciseType
}

extension Exercise {
    static var empty: Exercise {
        Exercise(title: "", howTo: "", equipment: .none, primaryMuscleGroup: .other, otherMuscleGroup: .other, exerciseType: .other)
    }
}
