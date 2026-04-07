//
//  ExerciseEndpoint.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

enum ExerciseEndpoint: FirestoreEndpoint {
    typealias DTO = ExerciseDTO
    static let path: String = "exercises"
}
