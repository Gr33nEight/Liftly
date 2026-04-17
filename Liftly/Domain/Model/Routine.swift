//
//  Routine.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//
import SwiftUI

struct Routine: Identifiable {
    let id: String
    let title: String
    let exercisesIds: [String]
    let ownerId: String
}


struct CreateRoutineInput {
    var title: String
    var trackedExercises: [TrackedExerciseEntry]
    var ownerId: String
}
