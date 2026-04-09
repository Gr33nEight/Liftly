//
//  SetType.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//


enum SetType: CaseIterable, Hashable {
    case warmUp
    case normal(Int)
    case failure
    case drop
    
    var rawValue: Int {
        switch self {
        case .warmUp: return 0
        case .normal: return 1
        case .failure: return 2
        case .drop: return 3
        }
    }
    
    var displayedValue: String {
        switch self {
        case .warmUp: return "W"
        case .normal(let value): return "\(value)"
        case .failure: return "F"
        case .drop: return "D"
        }
    }
    
    static var allCases: [SetType] {
        return [
            .warmUp,
            .normal(0),
            .failure,
            .drop
        ]
    }
}
