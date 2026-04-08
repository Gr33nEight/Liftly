//
//  ExerciseDTO.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation
@preconcurrency import FirebaseFirestore

struct ExerciseDTO: Codable, Sendable {
    @DocumentID var id: String?
    var workoutId: String
    var title: String
    var image: String
    var howTo: String
    var equipment: Int
    var primaryMuscleGroup: Int
    var otherMuscleGroup: Int
    var exerciseType: Int
    var restTime: String
    var sets: [ExerciseSetDTO]
}


