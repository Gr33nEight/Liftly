//
//  RoutineEntry.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

struct RoutineEntry {
    var id: String
    var title: String
    var exercises: [Exercise]
    let ownerId: String
    
    var exerciseTitles: [String] {
        exercises.map(\.title)
    }
}

