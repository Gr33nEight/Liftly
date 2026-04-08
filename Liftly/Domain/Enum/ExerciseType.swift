//
//  ExerciseType.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//


enum ExerciseType: Int, CaseIterable, Codable {
    case weightReps = 0
    case bodyweightReps
    case weightedBodyweight
    case duration
    case durationWeight
    case distanceDuration
    case weightDistance
    case other
    
    init(from decoder: Decoder) throws {
       let raw = try decoder.singleValueContainer().decode(Int.self)
       self = ExerciseType(rawValue: raw) ?? .other
   }
}

extension ExerciseType {
    var displayName: String {
        switch self {
        case .weightReps: return "Weight & Reps"
        case .bodyweightReps: return "Bodyweight Reps"
        case .weightedBodyweight: return "Weighted Bodyweight"
        case .duration: return "Duration"
        case .durationWeight: return "Duration + Weight"
        case .distanceDuration: return "Distance & Duration"
        case .weightDistance: return "Weight & Distance"
        case .other: return "Other"
        }
    }
}

extension ExerciseType {
    func defaultValue() -> ExerciseValue {
        switch self {

        case .weightReps:
            return .weightReps(weight: 0, reps: 0)

        case .bodyweightReps:
            return .bodyweightReps(reps: 0)

        case .weightedBodyweight:
            return .weightedBodyweight(weight: 0, reps: 0)

        case .duration:
            return .duration(seconds: 0)

        case .durationWeight:
            return .durationWeight(seconds: 0, weight: 0)

        case .distanceDuration:
            return .distanceDuration(distance: 0, seconds: 0)

        case .weightDistance:
            return .weightDistance(weight: 0, distance: 0)

        case .other:
            return .other("")
        }
    }
}
