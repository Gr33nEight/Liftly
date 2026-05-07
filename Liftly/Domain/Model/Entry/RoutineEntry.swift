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
    var trackedExercises: [TrackedExerciseEntry]
    let ownerId: String
    
    var exerciseTitles: [String] {
        trackedExercises.map(\.exercise).map(\.title)
    }
}

