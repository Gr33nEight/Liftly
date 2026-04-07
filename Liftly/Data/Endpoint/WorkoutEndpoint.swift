//
//  WorkoutDTO.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

enum WorkoutEndpoint: FirestoreEndpoint {
    typealias DTO = WorkoutDTO
    static let path: String = "workouts"
}
