//
//  ExerciseDTO.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation
@preconcurrency import FirebaseFirestore

struct TrackedExerciseDTO: Codable, Sendable {
    @DocumentID var id: String?
    var workoutId: String
    var exerciseId: String
    var restTime: Int
    var sets: [ExerciseSetDTO]
}


