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
    let container = AppContainer()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            container.makeAppEntry()
        }
    }
}
