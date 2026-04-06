//
//  SetType.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//


enum SetType: CaseIterable {
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
    
    static var allCases: [SetType] {
        return [
            .warmUp,
            .normal(0),
            .failure,
            .drop
        ]
    }
}
