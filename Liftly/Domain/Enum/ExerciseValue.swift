//
//  ExerciseValue.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//


enum ExerciseValue: Codable, Sendable {
    case weightReps(weight: Double, reps: Int)
    case bodyweightReps(reps: Int)
    case weightedBodyweight(weight: Double, reps: Int)
    case duration(seconds: Int)
    case durationWeight(seconds: Int, weight: Double)
    case distanceDuration(distance: Double, seconds: Int)
    case weightDistance(weight: Double, distance: Double)
    case other(String)
}

extension ExerciseValue {
    var volume: Double {
        switch self {
        case .weightReps(let weight, let reps):
            return weight * Double(reps)

        case .bodyweightReps(let reps):
            return Double(reps)

        case .weightedBodyweight(let weight, let reps):
            return weight * Double(reps)
            
        case .duration:
            return 0

        case .durationWeight(_, let weight):
            return weight

        case .distanceDuration:
            return 0

        case .weightDistance(let weight, _):
            return weight

        case .other:
            return 0
        }
    }
}

extension ExerciseValue {
    func matches(_ type: ExerciseType) -> Bool {
        switch (self, type) {

        case (.weightReps, .weightReps): return true
        case (.bodyweightReps, .bodyweightReps): return true
        case (.duration, .duration): return true
        case (.durationWeight, .durationWeight): return true
        case (.distanceDuration, .distanceDuration): return true
        case (.weightDistance, .weightDistance): return true

        default: return false
        }
    }
}
