//
//  LiftlyApp.swift
//  Liftly
//
//  Created by Natanael Jop on 01/04/2026.
//

import SwiftUI
import Firebase

@main
struct LiftlyApp: App {
    let helperService = ExerciseService()
    let container = AppContainer()
    
    init() {
        FirebaseApp.configure()
        _ = ExerciseStorage.shared.load()
    }
    
    var body: some Scene {
        WindowGroup {
            container.makeAppEntry()
        }
    }
}
