//
//  Exercise.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

struct Exercise: Codable, Sendable, Hashable {
    var id: String
    var title: String
    var imageUrl: URL?
    var videoUrl: URL?
    var howTo: String
    var equipment: Equipment
    var primaryMuscleGroup: MuscleGroup
    var otherMuscleGroup: MuscleGroup
    var exerciseType: ExerciseType
}

extension Exercise {
    static var empty: Exercise {
        Exercise(id: "", title: "", howTo: "", equipment: .none, primaryMuscleGroup: .other, otherMuscleGroup: .other, exerciseType: .other)
    }
}
