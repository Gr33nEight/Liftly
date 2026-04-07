//
//  MuscleGroup.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//


enum MuscleGroup: Int, CaseIterable, Codable {
    case abdominals
    case abductors
    case adductors
    case biceps
    case calves
    case cardio
    case chest
    case forearms
    case fullBody
    case glutes
    case hamstrings
    case lats
    case lowerBack
    case neck
    case quadriceps
    case shoulders
    case traps
    case triceps
    case upperBack
    case other
}

extension MuscleGroup {
    var displayName: String {
        switch self {
        case .abdominals: return "Abs"
        case .abductors: return "Abductors"
        case .adductors: return "Adductors"
        case .biceps: return "Biceps"
        case .calves: return "Calves"
        case .cardio: return "Cardio"
        case .chest: return "Chest"
        case .forearms: return "Forearms"
        case .fullBody: return "Full Body"
        case .glutes: return "Glutes"
        case .hamstrings: return "Hamstrings"
        case .lats: return "Lats"
        case .lowerBack: return "Lower Back"
        case .neck: return "Neck"
        case .quadriceps: return "Quads"
        case .shoulders: return "Shoulders"
        case .traps: return "Traps"
        case .triceps: return "Triceps"
        case .upperBack: return "Upper Back"
        case .other: return "Other"
        }
    }
}
