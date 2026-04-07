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

extension ExerciseType {
    var displayName: String {
        switch self {
        case .weightReps: return "Weight & Reps"
        case .bodyweightReps: return "Bodyweight Reps"
        case .weightedBodyweight: return "Weighted Bodyweight"
        case .assistedBodyweight: return "Assisted Bodyweight"
        case .duration: return "Duration"
        case .durationWeight: return "Duration + Weight"
        case .distanceDuration: return "Distance & Duration"
        case .weightDistance: return "Weight & Distance"
        case .other: return "Other"
        }
    }
}
