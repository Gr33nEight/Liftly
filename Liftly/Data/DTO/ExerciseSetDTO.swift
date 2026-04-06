//
//  ExerciseSetDTO.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//


struct ExerciseSetDTO: Codable, Sendable {
    var number: Int?
    var type: Int
    var previous: String
    var value: String
    var personalRecord: Bool
}
