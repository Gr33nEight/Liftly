//
//  RoutineEndpoint.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

enum RoutineEndpoint: FirestoreEndpoint {
    typealias DTO = RoutineDTO
    static let path: String = "routines"
}
