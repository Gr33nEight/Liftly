//
//  ShowExerciseListType.swift
//  Liftly
//
//  Created by Natanael Jop on 10/04/2026.
//


enum ShowExerciseListType: Identifiable {
    var id: Int {
        switch self {
        case .add:
            return 0
        case .replace(_):
            return 1
        }
    }
    
    case add
    case replace(String)
}