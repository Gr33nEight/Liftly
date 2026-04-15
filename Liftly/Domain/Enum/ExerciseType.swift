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
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            self = .other
            return
        }
        
        if let raw = try? container.decode(Int.self) {
            self = ExerciseType(rawValue: raw) ?? .other
        } else {
            self = .other
        }
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
    
    func configure(set: inout ExerciseSet) {
        switch self {
        case .weightReps:
            set.weight = 0
            set.reps = 0
            
        case .bodyweightReps:
            set.reps = 0
            
        case .duration:
            set.seconds = 0
            
        case .durationWeight:
            set.seconds = 0
            set.weight = 0
            
        case .distanceDuration:
            set.distance = 0
            set.seconds = 0
            
        default:
            break
        }
    }
    
    var usesWeight: Bool {
        switch self {
        case .weightReps, .durationWeight, .weightDistance:
            return true
        default: return false
        }
    }
    
    var usesReps: Bool {
        switch self {
        case .weightReps, .bodyweightReps:
            return true
        default: return false
        }
    }
    
    var usesDuration: Bool {
        switch self {
        case .duration, .durationWeight, .distanceDuration:
            return true
        default: return false
        }
    }
    
    var usesDistance: Bool {
        switch self {
        case .distanceDuration, .weightDistance:
            return true
        default: return false
        }
    }
}
