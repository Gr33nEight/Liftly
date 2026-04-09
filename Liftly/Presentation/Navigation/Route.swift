//
//  Route.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

enum Route: Hashable {
    case otherProfile
    case comments
    case workoutDetail
    case routine
    case activeWorkout(routineId: String)
}
