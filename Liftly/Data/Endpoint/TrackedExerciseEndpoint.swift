//
//  ExerciseEndpoint.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

enum TrackedExerciseEndpoint: FirestoreEndpoint {
    typealias DTO = TrackedExerciseDTO
    static let path: String = "trackedExercises"
}
