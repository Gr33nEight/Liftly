//
//  PostDTO 2.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//


@preconcurrency import FirebaseFirestore

struct WorkoutDTO: Codable, Sendable {
    @DocumentID var id: String?
    var workoutId: String
    var duration: Int
    var volume: Int
    var sets: Int
    var exercisesIds: [String]
}
