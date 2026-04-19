//
//  Equipment.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//


enum Equipment: Int, CaseIterable, Codable {
    case none = 0
    case barbell
    case dumbbell
    case kettlebell
    case machine
    case plate
    case resistanceBand
    case suspensionBand
    case other
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            self = .other
            return
        }
        
        if let raw = try? container.decode(Int.self) {
            self = Equipment(rawValue: raw) ?? .other
        } else {
            self = .other
        }
    }
}

extension Equipment {
    var displayName: String {
        switch self {
        case .none: return "No Equipment"
        case .barbell: return "Barbell"
        case .dumbbell: return "Dumbbell"
        case .kettlebell: return "Kettlebell"
        case .machine: return "Machine"
        case .plate: return "Weight Plate"
        case .resistanceBand: return "Resistance Band"
        case .suspensionBand: return "Suspension Trainer"
        case .other: return "Other"
        }
    }
}
