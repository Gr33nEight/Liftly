//
//  ExerciseSet.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import SwiftUI

struct ExerciseSet: Identifiable {
    var id: String = UUID().uuidString
    var type: SetType
    var isDone: Bool = false
    var weight: Double?
    var reps: Int?
    var seconds: Int?
    var distance: Int?
}

extension ExerciseSet {
    static func create(
        type: SetType,
        exerciseType: ExerciseType
    ) -> ExerciseSet {
        var set = ExerciseSet(type: type)
        exerciseType.configure(set: &set)
        return set
    }
}

extension ExerciseSet {
    var volume: Double {
        if let weight, let reps {
            return weight * Double(reps)
        }
        return 0
    }
}
