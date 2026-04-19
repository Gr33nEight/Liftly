//
//  RoutineDTO.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation
@preconcurrency import FirebaseFirestore

struct RoutineDTO: Codable, Sendable {
    @DocumentID var id: String?
    var title: String
    var exercisesIds: [String]
    let ownerId: String
}
