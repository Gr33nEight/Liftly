//
//  ExerciseType.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//


enum ExerciseType: Int, CaseIterable, Codable {
    case weightReps
    case bodyweightReps
    case weightedBodyweight
    case assistedBodyweight
    case duration
    case durationWeight
    case distanceDuration
    case weightDistance
    case other
}
